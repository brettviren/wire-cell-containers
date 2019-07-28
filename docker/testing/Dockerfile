FROM brettviren/wct-deb
MAINTAINER Brett Viren <brett.viren@gmail.com>


ARG username=testing
RUN useradd --create-home --home-dir /home/${username} ${username}
ADD run.sh /home/${username}/
RUN chmod +x /home/${username}/run.sh
RUN chown ${username} /home/${username}/run.sh

ENV HOME /home/${username}
ENV PATH=/home/${username}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
USER ${username}
WORKDIR /home/${username}

# ENTRYPOINT ["/home/testing/run.sh"]
