FROM scientificlinux/sl:7
MAINTAINER Haiwang Yu <yuhw.pku@gmail.com>

RUN yum -y install bash curl wget gcc gcc-c++
RUN yum -y install bash curl wget gcc gcc-c++
RUN wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -ivh epel-release-latest-7.noarch.rpm
RUN yum repolist
RUN yum -y install tar hostname redhat-lsb-core lbzip2 zlib-devel which git make cmake bison pkgconfig python emacs jq vim time openssl-devel python-pip python-hashlib ipython numpy python-matplotlib readline glibc-devel bzip2 python-devel jq libuuid libuuid-devel ccache distcc valgrind graphviz
RUN yum -y install http://ftp.scientificlinux.org/linux/scientific/7x/contexts/fermilab/x86_64/yum-conf-context-fermilab-1.0-6.el7.noarch.rpm
RUN sleep 2
RUN yum -y upgrade
RUN yum -y install fermilab-util_kx509 voms voms-clients-cpp globus-gss-assist globus-xio-gsi-driver globus-gsi-proxy-core globus-ftp-control uberftp yum-plugin-priorities myproxy-voms
RUN rpm -Uvh https://repo.opensciencegrid.org/osg/3.4/osg-3.4-el7-release-latest.rpm
RUN yum -y install osg-ca-certs vo-client
RUN yum clean all
RUN pip install --upgrade pip
RUN pip install virtualenv

RUN for n in ups src bin lib include opt share ; do mkdir -p /usr/local/$n ; done
