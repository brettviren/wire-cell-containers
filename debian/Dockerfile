FROM debian:buster
MAINTAINER Brett Viren <brett.viren@gmail.com>

COPY packages-base packages-base
COPY packages-dev packages-dev
COPY packages-run packages-run

RUN apt-get update -qq \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime

RUN apt-get -y install $(cat /packages-base) \
 && localedef -i en_US -f UTF-8 en_US.UTF-8 \
 && rm -f /packages-base

RUN apt-get -y install $(cat packages-dev) \
 && apt-get clean \
 && rm -rf /packages-dev

RUN cd /tmp \
 && wget -q https://root.cern/download/root_v6.16.00.source.tar.gz \
 && tar -xf root_v6.16.00.source.tar.gz

RUN cd /tmp \
 && cmake root-6.16.00 \
	-Dall=ON \
	-Dcxx17=ON \
	-Dfail-on-missing=ON \
	-Dgnuinstall=ON \
	-Drpath=ON \
	-Dbuiltin_afterimage=OFF \
	-Dbuiltin_ftgl=OFF \
	-Dbuiltin_gl2ps=OFF \
	-Dbuiltin_glew=OFF \
	-Dbuiltin_unuran=ON \
	-Dbuiltin_vc=ON \
	-Dbuiltin_vdt=ON \
	-Dbuiltin_veccore=ON \
	-Dbuiltin_xrootd=ON \
	-Darrow=OFF \
	-Dcastor=OFF \
	-Dchirp=OFF \
	-Dgeocad=OFF \
	-Dglite=OFF \
	-Dhdfs=OFF \
        -Dmysql=OFF \
	-Dmonalisa=OFF \
	-Doracle=OFF \
	-Dpythia6=OFF \
	-Dpythia8=OFF \
	-Drfio=OFF \
	-Dsapdb=OFF \
	-Dsrp=OFF \
        -DPYTHON_EXECUTABLE=/usr/bin/python3 \
 && cmake --build . -- -j$(nproc) \
 && cmake --build . --target install \
 && rm -rf /tmp/*

RUN cd /tmp \
 && wget -q https://github.com/google/jsonnet/archive/v0.13.0.tar.gz \
 && tar -xf v0.13.0.tar.gz \
 && cd jsonnet-0.13.0 \
 && make -j $(nproc) \
 && make libjsonnet.so libjsonnet++.so && cp libjsonnet.so libjsonnet++.so /usr/local/lib \
 && make jsonnet jsonnetfmt && cp jsonnet jsonnetfmt /usr/local/bin \
 && cp include/*.h /usr/local/include \
 && rm -rf /tmp/*


RUN apt-get -y install $(cat packages-run) \
 && apt-get clean \
 && rm -f /packages-run

ARG username=wcdev
RUN useradd --create-home --home-dir /home/${username} ${username}
ENV HOME /home/${username}
ENV WIRECELL_PATH /home/${username}/cfg:/home/${username}/data
ENV PATH=/home/${username}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV LD_LIBRARY_PATH=/home/${username}/lib
USER ${username}
WORKDIR /home/${username}

RUN git clone https://github.com/WireCell/wire-cell-cfg.git cfg
RUN git clone https://github.com/WireCell/wire-cell-data.git data
RUN git clone https://github.com/WireCell/wire-cell-build.git src \
 && cd src \
 && ./switch-git-urls \
 && git submodule init \
 && git submodule update \
 && ./wcb configure --prefix=$HOME \
                    --with-jsonnet=/usr/local/lib \
                    --with-eigen-include=/usr/include/eigen3 \
                    --with-root=/usr/local \
 && ./wcb --notests install \
 && ./wcb --alltests 

 
 RUN cd src && ./wcb clean

CMD bash -l
