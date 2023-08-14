# podman build -t wirecell/sluser sluser/ 
FROM wirecell/slscisoft
MAINTAINER Brett Viren <brett.viren@gmail.com>

# extra packages
RUN yum -y install \
    bash curl wget tar hostname lbzip2 which git \
    make cmake bison pkgconfig emacs jq vim time bzip2 \
    valgrind graphviz xauth xdg-utils

# direnv
RUN curl -sfL https://direnv.net/install.sh | bin_path=/usr/local/bin bash

# RUN useradd -ms /usr/bin/bash user -g users

# USER user
#WORKDIR /home/user/
#RUN mkdir -p .ssh

ENTRYPOINT ["/usr/bin/bash", "-c"]

