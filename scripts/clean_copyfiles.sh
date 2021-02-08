#!/bin/bash
cd copy-files
rm $(ls | grep -v "empty") -rf
cd -
cd work
rm ./buildroot_initramfs_sysroot/root/* -rf
rm ./buildroot_initramfs/target/root/* -rf
rm ./buildroot_rootfs/target/root/* -rf
cd -
