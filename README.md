# MPI-Projects
Simple repository with small projects demonstrating openMPI in both C and Fortran90.
This repo uses Docker to allow for use across all host operating systems with minimal setup.

## Create the Docker image
The Docker image needs to be created locally.
It can be thought of as a recipe for a base OS, dependencies and provisioning for a complete virtual environment.
For this repo, the Docker image is based on Ubuntu 18.04 and is provisioned to:
* Have gcc, gfortran, and some standard linux tools installed
* Have directories setup in the virtual image that we will use in this repo. The file structure in the virtual image that will be important for this repo is
```
# binaries for openmpi
/runner/bin

# fortran codes
/runner/fortran

# c codes
/runner/c
```

The Docker image can be built locally with the bash script
```
$ ./build_docker_image
```
It will take a while to build becuase openmpi is built from source. 
This is only done 1 time to build the image and then that image will be used in new containers which will be created and destroyed as we like.

## Run a Docker container
Once the Docker image is built locally, it can be run in a container and we can get a shell into that container by simply running the bash script
```
$ ./start_docker_container
```
This script will create a container with the image we built previously, link our local volumes for `./fortran` and `./c` to the container volumes `/runner/fortran` and `/runner/c` respectively.
This volume linking is dynamic, so with the container running, you are able to create files or update files in the linked directories and they will update accordingly in the container filesystem.
This allows for local editing of codes in an IDE while running the codes in a stable virtual environment that can run in the background continuously.
