# The main Makefile for Penglai-enclave
# This repo will compose riscv-qemu, linux, penglai's monitor, 
# 	enclave driver/SDK and demo apps into a runnable one.
# The Makefile is modified from SiFive's freedom-u-sdk.
# 	-- Dong Du


# RISCV must set to point to a directory that contains
# a toolchain install tree that was built via other means.
ifndef RISCV
$(error RISCV is not set, no riscv toolchain for build)
endif
PATH := $(RISCV)/bin:$(PATH)
ISA ?= rv64imafdc
ABI ?= lp64d
ISA32 ?= rv32imafdc
ABI32 ?= ilp32d

MULTILIB_TOOLCHAIN ?= /home/penglai/penglai-multilib-toolchain-install/bin/

srcdir := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
srcdir := $(srcdir:/=)
confdir := $(srcdir)/conf
wrkdir := $(CURDIR)/work

copy_dir := $(CURDIR)/copy-files
buildroot_srcdir := $(srcdir)/penglai-buildroot
buildroot_initramfs_wrkdir := $(wrkdir)/buildroot_initramfs
buildroot_initramfs_tar := $(buildroot_initramfs_wrkdir)/images/rootfs.tar
buildroot_initramfs_config := $(confdir)/buildroot_initramfs_config
buildroot_initramfs_sysroot_stamp := $(wrkdir)/.buildroot_initramfs_sysroot
buildroot_initramfs_sysroot := $(wrkdir)/buildroot_initramfs_sysroot
buildroot_rootfs_wrkdir := $(wrkdir)/buildroot_rootfs
buildroot_rootfs_ext := $(buildroot_rootfs_wrkdir)/images/rootfs.ext4
buildroot_rootfs_config := $(confdir)/buildroot_rootfs_config

linux_srcdir := $(srcdir)/Penglai-Linux-TVM
linux_wrkdir := $(wrkdir)/linux-5.10.2
linux_defconfig := $(confdir)/linux_defconfig

linux_image := $(linux_wrkdir)/arch/riscv/boot/Image
linux_image_stripped := $(linux_srcdir)/vmlinux-stripped

vmlinux := $(linux_wrkdir)/vmlinux
vmlinux_stripped := $(linux_wrkdir)/vmlinux-stripped

# FIXME: sdk path in the file.mk 
sdk_srcdir := $(srcdir)/Penglai-sdk-TVM

opensbi := $(srcdir)/Penglai-Opensbi-TVM

target_platform := pt_area

qemu_srcdir := $(srcdir)/penglai-qemu
qemu_wrkdir := $(wrkdir)/riscv-qemu
qemu := $(qemu_wrkdir)/prefix/bin/qemu-system-riscv64

rootfs := $(wrkdir)/rootfs.bin

target := riscv64-unknown-linux-gnu
target32 := riscv32-unknown-linux-gnu

.PHONY: all force
all: $(qemu) $(opensbi) $(rootfs) $(sdk)
	@echo
	@echo "This image for Penglai has been generated for an ISA of $(ISA) and an ABI of $(ABI)"
	@echo "Type make qemu -j8 to run the image"
	@echo

$(buildroot_initramfs_wrkdir)/.config: $(buildroot_srcdir)
	#rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp $(buildroot_initramfs_config) $@
	$(MAKE) -C $< RISCV=$(RISCV) PATH=$(PATH) O=$(buildroot_initramfs_wrkdir) olddefconfig CROSS_COMPILE=riscv64-unknown-linux-gnu-

$(buildroot_initramfs_tar): $(buildroot_srcdir) $(buildroot_initramfs_wrkdir)/.config $(buildroot_initramfs_config) force
	$(MAKE) -C $< RISCV=$(RISCV) PATH=$(PATH) O=$(buildroot_initramfs_wrkdir)

.PHONY: buildroot_initramfs-menuconfig
buildroot_initramfs-menuconfig: $(buildroot_initramfs_wrkdir)/.config $(buildroot_srcdir)
	$(MAKE) -C $(dir $<) O=$(buildroot_initramfs_wrkdir) menuconfig
	$(MAKE) -C $(dir $<) O=$(buildroot_initramfs_wrkdir) savedefconfig
	cp $(dir $<)/defconfig conf/buildroot_initramfs_config

$(buildroot_rootfs_wrkdir)/.config: $(buildroot_srcdir)
	#rm -rf $(dir $@)
	mkdir -p $(dir $@)
	cp $(buildroot_rootfs_config) $@
	$(MAKE) -C $< RISCV=$(RISCV) PATH=$(PATH) O=$(buildroot_rootfs_wrkdir) olddefconfig

$(buildroot_rootfs_ext): $(buildroot_srcdir) $(buildroot_rootfs_wrkdir)/.config $(buildroot_rootfs_config) $(copy_dir)
	$(MAKE) -C $< RISCV=$(RISCV) PATH=$(PATH) O=$(buildroot_rootfs_wrkdir)

$(buildroot_initramfs_sysroot_stamp): $(buildroot_initramfs_tar) force
	mkdir -p $(buildroot_initramfs_sysroot)
	tar -xpf $< -C $(buildroot_initramfs_sysroot) --exclude ./dev --exclude ./usr/share/locale
	touch $@


$(linux_image): $(linux_srcdir) $(buildroot_initramfs_sysroot_stamp) force
	# make -C $(linux_srcdir) mrproper
	make -C $(linux_srcdir) O=${linux_wrkdir} ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- defconfig
	make -C $(linux_srcdir) O=${linux_wrkdir} \
	CONFIG_INITRAMFS_SOURCE="$(confdir)/initramfs.txt $(buildroot_initramfs_sysroot)" \
	CONFIG_INITRAMFS_ROOT_UID=$(shell id -u) \
	CONFIG_INITRAMFS_ROOT_GID=$(shell id -g) \
	CROSS_COMPILE=riscv64-unknown-linux-gnu- \
	ARCH=riscv \
	-j 8

$(opensbi): $(linux_image) $(sdk)
	cd $(opensbi) && \
	export CROSS_COMPILE=riscv64-unknown-elf- && \
	make clean && \
	make PLATFORM=generic FW_PAYLOAD_PATH=${linux_image}
	# make PLATFORM=generic FW_PAYLOAD_PATH=$(linux_image_stripped)

$(qemu): $(qemu_srcdir)
	rm -rf $(qemu_wrkdir)
	mkdir -p $(qemu_wrkdir)
	mkdir -p $(dir $@)
	cd $(qemu_wrkdir) && $</configure \
		--prefix=$(dir $(abspath $(dir $@))) \
		--target-list=riscv64-softmmu
	$(MAKE) -C $(qemu_wrkdir)
	$(MAKE) -C $(qemu_wrkdir) install
	touch -c $@
qemu-clean:
	rm -rf $(qemu_wrkdir)

$(rootfs): $(buildroot_rootfs_ext)
	cp $< $@

.PHONY: buildroot_initramfs_sysroot vmlinux
buildroot_initramfs_sysroot: $(buildroot_initramfs_sysroot)
vmlinux: $(vmlinux)

.PHONY: clean
clean:
	rm -rf -- $(linux_wrkdir)/vmlinux
	cd $(sdk_srcdir) && PENGLAI_SDK=$(sdk_srcdir) make clean && cd -
	cd $(sdk_srcdir)/enclave-driver && make clean && cd -
	cd $(opensbi) && make clean && cd -

include $(sdk_srcdir)/file.mk
# FIXME: Here we always re-compile sdk using the force target
.PHONY: force
sdk := $(sdk_srcdir)/enclave-driver/penglai.ko
$(sdk): $(linux_image) force
	cd $(sdk_srcdir)/enclave-driver && make
	cd $(sdk_srcdir) && PENGLAI_SDK=$(sdk_srcdir) MULTILIB_TOOLCHAIN=$(MULTILIB_TOOLCHAIN) make
	cp -r $(SDK_FILES) $(copy_dir)
	
sdk: $(sdk)

.PHONY: qemu
qemu: $(qemu)
	$(qemu) -nographic -M virt -m 4096M -smp 4 -kernel $(opensbi)/build/platform/generic/firmware/fw_payload.elf \
	-drive file=/home/penglai/penglai-enclave/work/rootfs.bin,format=raw,id=hd0 -device virtio-blk-device,drive=hd0 \
	-netdev user,id=net0 -device virtio-net-device,netdev=net0 \
	-append "root=/dev/vda rw console=ttyS0 earlyprintk=ttyS0"

.PHONY: qemu-gdb
qemu-gdb: $(qemu)
	$(qemu) -nographic -M virt -m 4096M -smp 4  -kernel $(opensbi)/build/platform/generic/firmware/fw_payload.elf \
	-drive file=/home/penglai/penglai-enclave/work/rootfs.bin,format=raw,id=hd0 -device virtio-blk-device,drive=hd0 \
	-netdev user,id=net0 -device virtio-net-device,netdev=net0 \
	-append "root=/dev/vda rw console=ttyS0" -S -gdb tcp::1234

