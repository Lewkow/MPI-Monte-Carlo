FROM ubuntu:18.04
COPY ./fortran/ /runner/fortran/
RUN apt -y update
RUN apt -y upgrade
RUN apt install -y build-essential gfortran wget
RUN mkdir /runner/bin
WORKDIR /runner/bin
RUN wget https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.0.tar.gz
RUN tar xf openmpi-4.1.0.tar.gz
WORKDIR /runner/bin/openmpi-4.1.0
RUN ./configure --prefix=/runner/bin
RUN make all install
WORKDIR /runner/fortran

