cd baseline-linux
run_func()
{
	./entry &
	./imageResize &
	./imageErosion &
	./imageRotate &
	sleep 3
	./serverless-user $1
}

run_func 32  
run_func 64  
run_func 128 
run_func 256 
run_func 512 
run_func 768 
run_func 1024 
run_func 1536 
run_func 2048 
cd ..