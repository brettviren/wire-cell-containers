# podman build -t wirecell/slscisoft slscisoft/

FROM docker.io/scientificlinux/sl:7
MAINTAINER Brett Viren <bv@bnl.gov>

# Some packages required by checkPrerequisites are in EPEL
RUN yum -y install epel-release

# Package list as checked by
# https://scisoft.fnal.gov/scisoft/bundles/tools/checkPrerequisites
RUN yum -y install \
    asciidoc autoconf automake bzip2-devel fontconfig-devel \
    freetype-devel ftgl-devel gcc gcc-c++ gdbm-devel giflib-devel \
    gl2ps-devel glew-devel glibc-devel glibc-devel.i686 harfbuzz-devel \
    libAfterImage-devel libX11-devel libXext-devel libXft-devel \
    libXi-devel libXmu-devel libXpm-devel libXrender-devel libXt-devel \
    libcurl-devel libffi-devel libgcc libgcc.i686 libjpeg-turbo-devel \
    libpng-devel libstdc++-devel libstdc++-devel.i686 libtool \
    libuuid-devel libxcb-devel libxkbcommon-devel \
    libxkbcommon-x11-devel libzstd-devel lz4-devel mesa-libGL-devel \
    mesa-libGLU-devel ncurses-devel openldap-devel openssl-devel \
    pcre2-devel perl-DBD-SQLite perl-ExtUtils-MakeMaker readline-devel \
    subversion swig tcl-devel texinfo tk-devel xcb-util-image-devel \
    xcb-util-keysyms-devel xcb-util-renderutil-devel xcb-util-wm-devel \
    xmlto xxhash-devel xz-devel zlib-devel zstd


# lsb_release is required but it's package not checked.  This provides
# it on sl7.
RUN yum -y install redhat-lsb-core

RUN yum -y upgrade


RUN yum clean all

# RUN for n in ups src bin lib include opt share ; do mkdir -p /usr/local/$n ; done

RUN curl -O https://scisoft.fnal.gov/scisoft/bundles/tools/checkPrerequisites
RUN bash checkPrerequisites

