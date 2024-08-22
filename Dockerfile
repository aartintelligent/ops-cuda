FROM debian:bookworm

ARG CUDA_VERSION

RUN apt-get update && apt-get install -y \
    ca-certificates \
    wget

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/cuda-keyring_1.1-1_all.deb \
    && dpkg -i cuda-keyring_1.1-1_all.deb

RUN apt-get update && apt-get install -y \
    cuda-toolkit-${CUDA_VERSION}
