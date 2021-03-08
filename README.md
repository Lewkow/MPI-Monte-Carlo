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

## MPI Projects

### Monte Carlo PI Calculation
Very simple numerical integration to determine the value of pi.
Every Monte Carlo dart is assigned a random x and y coordinate which can range from 0-1, putting the dart in the first quardrant of the unit x-y plane.
If the dart is within a circle of radius 1 centered on the origin, log a hit, else log a miss.
Area is then simply the ratio of hits to total darts and the value of pi is 4 times this ratio (4 * pi * r * r) where r is 1.

The script can be run with varying numbers of parallel threads to compare parallel speedup.
```
root@27a2df23a623:/runner/fortran# ./mc_pi_parallel_speedup_test 
 ---------------------------------------
 parallel processes:            1
 total test darts:    100000000
 runtime (sec):    5.3192481029999996     
 theoretical pi:    3.1415926535897931     
 simulated pi:    3.1417706012725830     
 percent error:    5.6642506655519755E-003
 ---------------------------------------
 parallel processes:            2
 total test darts:    100000000
 runtime (sec):    3.4949827849999999     
 theoretical pi:    3.1415926535897931     
 simulated pi:    3.1417145729064941     
 percent error:    3.8808123822708681E-003
 ---------------------------------------
 parallel processes:            3
 total test darts:    100000000
 runtime (sec):    2.4801485329999999     
 theoretical pi:    3.1415926535897931     
 simulated pi:    3.1414732933044434     
 percent error:    3.7993558844545811E-003
 ---------------------------------------
 parallel processes:            4
 total test darts:    100000000
 runtime (sec):    1.9525828370000000     
 theoretical pi:    3.1415926535897931     
 simulated pi:    3.1415975093841553     
 percent error:    1.5456473507502271E-004
```
