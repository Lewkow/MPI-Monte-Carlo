FROM ubuntu:18.04
COPY ./fortran/ /runner/fortran/
WORKDIR /runner/fortran
RUN apt -y update
RUN apt -y upgrade
RUN apt install -y build-essential gfortran
