FROM mono:4
MAINTAINER Nonobis <nonobis@gmail.com>

ENV VERSION 0.6.0

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get update -q
RUN apt-get install -qy libcurl4-openssl-dev zip unzip wget
RUN apt-get clean
RUN wget https://github.com/zone117x/Jackett/releases/download/v$VERSION/Jackett.Mono.v$VERSION.zip -O /tmp/jackett.zip
RUN unzip -tq /tmp/jackett.zip
RUN unzip /tmp/jackett.zip -d /app
RUN chown -R nobody:users /app
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir -p /config
RUN chown -R nobody:users /config
RUN ln -s /config /usr/share/Jackett

EXPOSE 9117
VOLUME /config
VOLUME /app

ADD start.sh /
RUN chmod +x /start.sh

# Currently there is a bug in Jackett where running as non-root user causes the app to not start up
# See: https://github.com/zone117x/Jackett/issues/37
# We could potentially start it initially as root and then kill it and then start as nobody, but for now, hoping
# the bug gets resolved.
#USER nobody
WORKDIR /app

ENTRYPOINT ["/start.sh"]
