##############
# penglai.ko
##############

export penglai_dir=$PWD/Penglai-sdk-TVM/enclave-driver
cp $penglai_dir/penglai.ko copy-files/


###########
# host
###########

if [ ! -d "copy-files/host" ]; then
  mkdir copy-files/host
fi

export host_dir=$PWD/Penglai-sdk-TVM/demo/host
cp $host_dir/host copy-files/host/

###########
# host-nb-attest
###########

if [ ! -d "copy-files/host-nb-attest" ]; then
  mkdir copy-files/host-no-attest
fi

export host_no_attest_dir=$PWD/Penglai-sdk-TVM/demo/host-no-attest
cp $host_no_attest_dir/host-no-attest copy-files/host-no-attest/

#############
# hello world
#############

if [ ! -d "copy-files/hello-world" ] ; then
  mkdir copy-files/hello-world
fi

export hello_world_dir=$PWD/Penglai-sdk-TVM/demo/hello-world
cp $hello_world_dir/hello-world copy-files/hello-world

#############
# sleep-demo
#############

if [ ! -d "copy-files/sleep-demo" ] ; then
  mkdir copy-files/sleep-demo
fi

export sleep_demo_dir=$PWD/Penglai-sdk-TVM/demo/sleep-demo
cp $sleep_demo_dir/sleep-demo copy-files/sleep-demo

###########
# rv8-test
###########

if [ ! -d "copy-files/rv8-test" ]; then
  mkdir copy-files/rv8-test
fi

export rv8_test_dir=$PWD/Penglai-sdk-TVM/demo/rv8
cp $rv8_test_dir/aes/aes copy-files/rv8-test/
cp $rv8_test_dir/dhrystone/dhrystone copy-files/rv8-test/
cp $rv8_test_dir/norx/norx copy-files/rv8-test/
cp $rv8_test_dir/primes/primes copy-files/rv8-test/
cp $rv8_test_dir/qsort/qsort copy-files/rv8-test/
cp $rv8_test_dir/sha512/sha512 copy-files/rv8-test/


###########
# coremark
###########

if [ ! -d "copy-files/coremark" ]; then
  mkdir copy-files/coremark
fi

export coremark_dir=$PWD/Penglai-sdk-TVM/demo/coremark
cp $coremark_dir/coremark copy-files/coremark/


#############
# stress-ng
#############

# if [ ! -d "copy-files/stress-ng" ]; then
#   mkdir copy-files/stress-ng
# fi

# export stress_ng_dir=$PWD/Penglai-sdk-TVM/demo/stress-ng
# cp $stress_ng_dir/stress-ng copy-files/stress-ng/


############
# lmbench
############

# if [ ! -d "copy-files/lmbench" ] ; then
#   mkdir copy-files/lmbench
# fi

# export lmbench_dir=$PWD/Penglai-sdk-TVM/demo/lmbench
# cp $lmbench_dir/bin/x86_64-linux-gnu/*mem* copy-files/lmbench
# cp $lmbench_dir/bin/x86_64-linux-gnu/*mmap* copy-files/lmbench


###############
# map-reduce
###############

if [ ! -d "copy-files/map-reduce" ] ; then
  mkdir copy-files/map-reduce
fi

export map_reduce_dir=$PWD/Penglai-sdk-TVM/demo/map-reduce
cp $map_reduce_dir/map/map copy-files/map-reduce
cp $map_reduce_dir/mphost/mphost copy-files/map-reduce
cp $map_reduce_dir/mphost/input.txt copy-files/map-reduce
cp $map_reduce_dir/reduce/reduce copy-files/map-reduce
cp $map_reduce_dir/map2/map2 copy-files/map-reduce
cp $map_reduce_dir/mphost2/mphost2 copy-files/map-reduce
cp $map_reduce_dir/reduce2/reduce2 copy-files/map-reduce
cp $map_reduce_dir/map4/map4 copy-files/map-reduce
cp $map_reduce_dir/mphost4/mphost4 copy-files/map-reduce
cp $map_reduce_dir/reduce4/reduce4 copy-files/map-reduce


##############
# ipc
##############

if [ ! -d "copy-files/ipc" ] ; then
  mkdir copy-files/ipc
fi

export ipc_dir=$PWD/Penglai-sdk-TVM/demo/ipc
cp $ipc_dir/caller/caller copy-files/ipc
cp $ipc_dir/server/server copy-files/ipc
#cp $ipc_dir/server1/server1 copy-files/ipc
cp $ipc_dir/test-caller/test-caller copy-files/ipc


################
# scalability
################

if [ ! -d "copy-files/small-demo" ] ; then
  mkdir copy-files/small-demo
fi

export small_demo_dir=$PWD/Penglai-sdk-TVM/demo/small-demo
cp $small_demo_dir/small-demo2/small-demo2 copy-files/small-demo
cp $small_demo_dir/small-demo16/small-demo16 copy-files/small-demo


#############
# fast boot
#############

if [ ! -d "copy-files/fastboot" ] ; then
  mkdir copy-files/fastboot
fi

export fastboot_dir=$PWD/Penglai-sdk-TVM/demo/fastboot
#cp $fastboot_dir/host-shm/host-shm copy-files/fastboot
#cp $fastboot_dir/host-no-shm/host-no-shm copy-files/fastboot
#cp $fastboot_dir/shadow-host-shm/shadow-host-shm copy-files/fastboot
cp $fastboot_dir/shadow-host-no-shm/shadow-host-no-shm copy-files/fastboot

################
# serverless
################

if [ ! -d "copy-files/serverless-test" ] ; then
  mkdir copy-files/serverless-test
fi

export serverless_test_dir=$PWD/Penglai-sdk-TVM/demo/image-process/serverless_test
cp $serverless_test_dir/serverless-user copy-files/serverless-test
cp $serverless_test_dir/entry_enclave copy-files/serverless-test
cp $serverless_test_dir/imageResize copy-files/serverless-test
cp $serverless_test_dir/imageRotate copy-files/serverless-test
cp $serverless_test_dir/imageErosion copy-files/serverless-test