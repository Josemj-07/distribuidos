FROM ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        rpcsvc-proto \
        libtirpc-dev \
        rpcbind \
        net-tools \
        iputils-ping \
        nano \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /lab
CMD ["bash"]
