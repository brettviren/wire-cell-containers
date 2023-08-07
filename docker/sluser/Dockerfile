# podman build -t wirecell/sluser sluser/ 
FROM wirecell/slscisoft
MAINTAINER Brett Viren <brett.viren@gmail.com>

# extra packages
RUN yum -y install \
    bash curl wget tar hostname lbzip2 which git \
    make cmake bison pkgconfig emacs jq vim time bzip2 valgrind graphviz

# Incredibly usefull for maintaining a binding of shell environment to a directory. 
RUN yum -y install https://kojipkgs.fedoraproject.org//vol/fedora_koji_archive02/packages/direnv/2.12.2/1.fc28/x86_64/direnv-2.12.2-1.fc28.x86_64.rpm

# A better shell.
RUN yum -y install https://download.opensuse.org/repositories/shells:/fish:/release:/3/CentOS_7/x86_64/fish-3.6.1-1.2.x86_64.rpm

# RUN useradd -ms /usr/bin/bash user -g users

# USER user
#WORKDIR /home/user/
#RUN mkdir -p .ssh

ENTRYPOINT ["/usr/bin/bash", "-c"]

