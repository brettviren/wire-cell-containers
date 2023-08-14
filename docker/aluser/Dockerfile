FROM brettviren/al9fnal
MAINTAINER Brett Viren <brett.viren@gmail.com>

RUN useradd -ms /bin/bash user -g users
USER user
WORKDIR /home/user/
RUN mkdir -p .ssh

RUN wget https://scisoft.fnal.gov/scisoft/bundles/tools/checkPrerequisites
RUN wget https://scisoft.fnal.gov/scisoft/bundles/tools/checkPrerequisites-v2
RUN bash checkPrerequisites-v2

# run with --userns=keep-id
