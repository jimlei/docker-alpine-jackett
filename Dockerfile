FROM mono:3.10
MAINTAINER ammmze <ammmze@gmail.com>

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
  && apt-get update -q \
  && apt-get install -qy libcurl4-openssl-dev unzip wget \
  && apt-get clean \
  && wget https://github.com/zone117x/Jackett/releases/download/v0.3.1/Release.v0.3.1.zip -O /tmp/jackett.zip \
  && unzip /tmp/jackett.zip -d /tmp/jackett \
  && mv /tmp/jackett/Release /app \
  && chown -R nobody:users /app \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /config \
  && chown -R nobody:users /config
  && ln -s /config /usr/share/Jackett

EXPOSE 9117
VOLUME /config
VOLUME /app

ADD start.sh /
RUN chmod +x /start.sh

#USER nobody
WORKDIR /app

ENTRYPOINT ["/start.sh"]
