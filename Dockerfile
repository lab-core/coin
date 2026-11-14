# Debian 13 (trixie) with GCC 14: the previous chain (legraina/cmake ->
# legraina/boost) sat on gcc:12.1, i.e. Debian 11, whose archive no longer
# serves security updates, so images built on top could not apt-get install.
FROM gcc:14

# Tools and libraries needed to build and run the coin-or suite and the
# projects built on top of this image (cmake, boost headers, java for the
# validators, valgrind for debugging).
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        cmake \
        default-jre-headless \
        libblas-dev \
        libboost-dev \
        libbz2-dev \
        liblapack-dev \
        pkg-config \
        time \
        valgrind \
        wget \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Install coin-or suite
COPY ./ /coin/
ENV PKG_CONFIG_PATH=/usr/lib/pkgconfig/
ARG MAKE_ARGS=""
RUN ./coin/install.sh -p /usr -c -wc -m "${MAKE_ARGS}" && rm -rf /coin
