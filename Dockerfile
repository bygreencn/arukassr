# ssr-with-net-speeder

FROM ubuntu:14.04.3
MAINTAINER malaohu <tua@live.cn>

# Define Libsodium version
ENV LIBSODIUM_VERSION 1.0.11

# Define workdir
WORKDIR /root

# Install some tools: gcc build tools, unzip, etc
RUN \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install curl build-essential unzip locate git python python-pip python-m2crypto libnet1-dev libpcap0.8-dev

# Download & extract & make libsodium
# Move libsodium build
RUN \
    mkdir -p /tmpbuild/libsodium && \
    cd /tmpbuild/libsodium && \
    curl -L https://download.libsodium.org/libsodium/releases/libsodium-${LIBSODIUM_VERSION}.tar.gz -o libsodium-${LIBSODIUM_VERSION}.tar.gz && \
    tar xfvz libsodium-${LIBSODIUM_VERSION}.tar.gz && \
    cd /tmpbuild/libsodium/libsodium-${LIBSODIUM_VERSION}/ && \
    ./configure && \
    make && make check && \
    make install && \
    mv src/libsodium /usr/local/ && \
    rm -Rf /tmpbuild/

RUN \
    apt-get update && \
    apt-get clean  

RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git ssr
RUN git clone https://github.com/snooda/net-speeder.git net-speeder
WORKDIR net-speeder
RUN sh build.sh

RUN mv net_speeder /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/net_speeder

# Start Net Speeder
#CMD ["nohup /usr/local/bin/net_speeder venet0 \"ip\" >/dev/null 2>&1 &"]

#Test 
#CMD ["ping www.baidu.com -c 5"]


# Configure container to run as an executable
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
