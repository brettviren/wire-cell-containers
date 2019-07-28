FROM debian:buster
MAINTAINER Brett Viren <brett.viren@gmail.com>

COPY packages packages

RUN apt-get update -qq \
 && ln -sf /usr/share/zoneinfo/UTC /etc/localtime \
 && apt-get -y install $(cat /packages) \
 && rm -f /packages \
 && apt-get clean \
 && rm -rf /usr/share/locale/[a-df-z]*

RUN pip3 install Nikola webassets

COPY install.el /root/install.el
WORKDIR /root
RUN emacs --batch -l install.el

ENV COMMIT_USER="WCT CI (Brett Viren)"
ENV COMMIT_EMAIL="bv@bnl.gov"
ENV SSH_KEY=""

COPY update.sh /root/update.sh
COPY anonbuild.sh /root/anonbuild.sh

RUN chmod +x /root/update.sh
RUN chmod +x /root/anonbuild.sh
RUN ./anonbuild.sh

