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

export init_dir=$PWD/Penglai-sdk-TVM/demo/dd-init
cp $init_dir/dd-init copy-files/host/

#############
# hello world
#############

if [ ! -d "copy-files/hello-world" ] ; then
  mkdir copy-files/hello-world
fi

export hello_world_dir=$PWD/Penglai-sdk-TVM/demo/hello-world
cp $hello_world_dir/hello-world copy-files/hello-world


################
# serverless
################

#if [ ! -d "copy-files/serverless-test" ] ; then
#  mkdir copy-files/serverless-test
#fi
#
#export serverless_test_dir=$PWD/Penglai-sdk-TVM/demo/image-process/serverless_test
#cp $serverless_test_dir/serverless-user copy-files/serverless-test
#cp $serverless_test_dir/entry_enclave copy-files/serverless-test
#cp $serverless_test_dir/imageResize copy-files/serverless-test
#cp $serverless_test_dir/imageRotate copy-files/serverless-test
#cp $serverless_test_dir/imageErosion copy-files/serverless-test
#
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
# cp $map_reduce_dir/map2/map2 copy-files/map-reduce
# cp $map_reduce_dir/mphost2/mphost2 copy-files/map-reduce
# cp $map_reduce_dir/reduce2/reduce2 copy-files/map-reduce
# cp $map_reduce_dir/map4/map4 copy-files/map-reduce
# cp $map_reduce_dir/mphost4/mphost4 copy-files/map-reduce
# cp $map_reduce_dir/reduce4/reduce4 copy-files/map-reduce
