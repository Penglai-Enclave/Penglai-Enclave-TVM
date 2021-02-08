#!/bin/bash

function print_usage() {
	RED='\033[0;31m'
	BLUE='\033[0;34m'
	BOLD='\033[1m'
	NONE='\033[0m'

	echo -e "\n${RED}Usage${NONE}:
	.${BOLD}/docker_cmd.sh${NONE} [OPTION]"

	echo -e "\n${RED}OPTIONS${NONE}:
	${BLUE}build${NONE}: build penglai-demo image
	${BLUE}run-qemu${NONE}: run penglai-demo image in (modified) qemu 
	"
}

# no arguments
if [ $# == 0 ]; then
	echo "Default: building penglai demo image"
	docker run -v $(pwd):/home/penglai/penglai-enclave -w /home/penglai/penglai-enclave --rm -it ddnirvana/penglai-enclave:v0.4 bash scripts/build.sh
	exit 0
fi

if [[ $1 == *"help"* ]]; then
	print_usage
	exit 0
fi

# build penglai 
if [[ $1 == "build" ]]; then
	echo "Build: building penglai demo image"
	docker run -v $(pwd):/home/penglai/penglai-enclave -w /home/penglai/penglai-enclave --rm -it ddnirvana/penglai-enclave:v0.4 bash scripts/build.sh
	exit 0
fi

# build penglai-32-nommu
if [[ $1 == "build32" ]]; then
	echo "Build: building penglai-32-nommu demo image"
	docker run -v $(pwd):/home/penglai/penglai-enclave -w /home/penglai/penglai-enclave --rm -it ddnirvana/penglai-enclave:v0.4 bash scripts/build32.sh
	exit 0
fi

# run penglai 
if [[ $1 == "qemu" ]]; then
	echo "Run: run penglai demo image in sPMP-supported Qemu"
	docker run -v $(pwd):/home/penglai/penglai-enclave -w /home/penglai/penglai-enclave --rm -it ddnirvana/penglai-enclave:v0.4 bash scripts/run-qemu.sh
	exit 0
fi

# run penglai 
if [[ $1 == "qemu32" ]]; then
	echo "Run: run penglai32-nommu demo image in Qemu"
	docker run -v $(pwd):/home/penglai/penglai-enclave -w /home/penglai/penglai-enclave --rm -it ddnirvana/penglai-enclave:v0.4 bash scripts/run-qemu32.sh
	exit 0
fi

# run penglai with freertos
if [[ $1 == "freertos" ]]; then
	echo "Run: run freertos demo image in Qemu"
	docker run -v $(pwd):/home/penglai/penglai-enclave -w /home/penglai/penglai-enclave --rm -it ddnirvana/penglai-enclave:v0.4 bash scripts/run-freertos.sh
	exit 0
fi

# run docker 
if [[ $1 == *"docker"* ]]; then
	echo "Run: run docker"
	#sudo docker run --privileged --cap-add=ALL  -v $(pwd):/home/penglai/penglai-enclave -w /home/penglai/penglai-enclave --rm -it ddnirvana/penglai-enclave:v0.2
	docker run -v $(pwd):/home/penglai/penglai-enclave -w /home/penglai/penglai-enclave --rm -it ddnirvana/penglai-enclave:v0.4
	exit 0
fi

# make clean
if [[ $1 == *"clean"* ]]; then
	echo "Clean: make clean"
	docker run -v $(pwd):/home/penglai/penglai-enclave -w /home/penglai/penglai-enclave --rm -it ddnirvana/penglai-enclave:v0.4 make clean
	exit 0
fi


print_usage
exit 1
