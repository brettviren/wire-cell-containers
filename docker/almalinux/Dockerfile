## WARNING: there is not yet FNAL UPS support for AL9 as of
## WARNING: Fri Aug  4 09:17:51 AM EDT 2023
## WARNING: don't waste your time with this image until that changes.

FROM almalinux:9
MAINTAINER Brett viren <bv@bnl.gov>

RUN dnf -y install epel-release
RUN dnf -y install yum-utils
RUN dnf -y config-manager --set-enabled crb

# From SciSoft's checkPrerequisites-v2
RUN dnf -y install asciidoc autoconf automake bzip2-devel epel-release \
    fontconfig-devel freetype-devel ftgl-devel gcc gcc-c++ gdbm-devel \
    giflib-devel gl2ps-devel glew-devel glibc-devel harfbuzz-devel \
    libAfterImage-devel libX11-devel libXext-devel libXft-devel \
    libXi-devel libXmu-devel libXpm-devel libXrender-devel libXt-devel \
    libcurl-devel libffi-devel libgcc libjpeg-turbo-devel libpng-devel \
    libstdc++-devel libtool libuuid-devel libxcb-devel \
    libxkbcommon-devel libxkbcommon-x11-devel libzstd-devel lz4-devel \
    mesa-libGL-devel mesa-libGLU-devel ncurses-devel openldap-devel \
    openssl-devel pcre2-devel perl-DBD-SQLite perl-ExtUtils-MakeMaker \
    readline-devel subversion swig tcl-devel texinfo tk-devel \
    xcb-util-image-devel xcb-util-keysyms-devel \
    xcb-util-renderutil-devel xcb-util-wm-devel xmlto xxhash-devel \
    xz-devel zlib-devel zstd

# extras, though many can be had from /cvmfs
RUN dnf -y install bash wget tar hostname lbzip2 python3 which git \
    make cmake bison pkgconfig emacs jq vim time  readline bzip2 valgrind graphviz

RUN dnf -y install openssl-devel libxcrypt-compat xz-devel

# redhat-lsb-core
#
# Is not having lsb_release in al9 a deal breaker?  https://redd.it/wjlh0s
# 

# FNAL specific
# RUN dnf -y install https://linux-mirrors.fnal.gov/linux/almalinux/almalinux-repos-latest-9.x86_64.rpm
# RUN dnf -y install https://linux-mirrors.fnal.gov/linux/fermilab/almalinux/9/yum-conf-fermilab.rpm
# RUN dnf -y upgrade
# RUN dnf -y install fermilab-util_kx509 voms voms-clients-cpp globus-gss-assist globus-xio-gsi-driver globus-gsi-proxy-core globus-ftp-control uberftp myproxy-voms

#  yum-plugin-priorities
#RUN dnf -y install osg-ca-certs vo-client

RUN dnf clean all
# RUN pip install --upgrade pip
# RUN pip install virtualenv

RUN for n in ups src bin lib include opt share ; do mkdir -p /usr/local/$n ; done


COPY lsb_release /usr/bin/lsb_release
