cd ipc
./test-caller caller server 2
./test-caller caller server 64
./test-caller-baseline caller-baseline server-baseline 2
./test-caller-baseline caller-baseline server-baseline 64
cd ../
