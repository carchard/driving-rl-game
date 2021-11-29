# multi-stage build starting with Ubuntu as the base
FROM ubuntu:20.04 AS base

# install all dependencies as first later
RUN apt-get update 
RUN apt-get install -y gcc make cmake openssh-server openssh-client

# second start of the multi-stage build where all the source
# code is brought into the container and is then compiled
FROM base as gamesource

# bring the code over
COPY ./ /usr/app

# execute the CMake
RUN cd /usr/app && mkdir build && cd build && cmake .. && make -j4

# run the main
ENTRYPOINT /usr/app/main
