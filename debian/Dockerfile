FROM debian:buster
MAINTAINER Brett Viren <brett.viren@gmail.com>

COPY packages packages

RUN apt-get update -qq \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get -y install $(cat /packages) \
 && rm -f /packages \
 && apt-get clean \
 && rm -rf /usr/share/locale/[a-df-z]* 


#RUN wget -q https://github.com/google/jsonnet/archive/v0.13.0.tar.gz
#RUN tar -xf v0.13.0.tar.gz
#RUN cd jsonnet-0.13.0 && cmake . && make -j$(nproc)
## For now we need some bug fixes not in 0.13.
RUN cd /root && \
    git clone https://github.com/google/jsonnet.git && \
    cd jsonnet && \
    git checkout -b pre14 24424c61e8abaf730e93096f4de2d51a9a9011b1 && \
    make -j$(nproc) && make install && \
    cd /root && \
    rm -rf jsonnet

