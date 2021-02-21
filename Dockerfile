FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
RUN apt-get update && \
    # install all dependencies
    apt install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    gpg-agent \
    libc++-10-dev \
    libc++abi-10-dev \
    lsb-release \
    openssh-server \
    shunit2 \
    software-properties-common \
    sudo \
    wget \
    && \
    # install llvm-10
    curl https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    add-apt-repository "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-10 main" && \
    apt-get install -y --no-install-recommends \
    clang-10 \
    lldb-10 \
    lld-10 \
    clangd-10 && \
    rm -rf /var/lib/apt/lists/*

# download bc-* packages
RUN git clone https://github.com/blockchaincommons/bc-crypto-base && \
    git clone https://github.com/BlockchainCommons/bc-sskr && \
    git clone https://github.com/blockchaincommons/bc-shamir  && \
    git clone https://github.com/blockchaincommons/bc-bip39 && \
    git clone https://github.com/blockchaincommons/bc-ur && \
    git clone https://github.com/BlockchainCommons/bc-seedtool-cli

RUN \
    # bc-crypto-base
    cd ~/bc-crypto-base && \
    ./configure && \
    make check && \
    make install && \
    #
    # bc-bip39
    cd ~/bc-bip39  && \
    ./configure && \
    make check && \
    make install && \
    #
    # bc-shamir
    cd ~/bc-shamir && \
    ./configure && \
    make check && \
    make install && \
    #
    # bc-sskr
    cd ~/bc-sskr && \
    ./configure && \
    make check && \
    make install && \
    #
    # bc-ur
    cd ~/bc-ur && \
    export CC="clang-10" && export CXX="clang++-10" && ./configure  && \
    make check && \
    make install && \
    #
    # bc-seedtool-cli
    cd ~/bc-seedtool-cli && \
    export CC="clang-10" && export CXX="clang++-10" && ./build.sh && \
    make install

CMD [ "/usr/local/bin/seedtool" ]
