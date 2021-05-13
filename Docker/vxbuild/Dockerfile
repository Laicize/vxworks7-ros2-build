FROM ubuntu:latest

RUN apt-get update && apt-get upgrade && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  unzip bc git wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV GID 1000
ENV GROUP wruser
ENV UID 1000
ENV USER wruser
ENV HOME /home/${USER}
ENV WRENV vxworks/21.03

COPY ./docker-entrypoint.sh /

# make /bin/sh symlink to bash instead of dash:
RUN echo "dash dash/sh boolean false" | debconf-set-selections \
&& DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

WORKDIR /work

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/bash"]
