# Run vmpooler in a Docker container!  Configuration can either be embedded
# and built within the current working directory, or stored in a
# VMPOOLER_CONFIG environment value and passed to the Docker daemon.
#
# BUILD:
#   docker build -t vmpooler .
#
# RUN:
#   docker run -e VMPOOLER_CONFIG -p 80:4567 -it vmpooler

FROM jruby:9.1-jdk
RUN apt-get -y update && apt-get -y install vim
RUN mkdir -p /var/lib/vmpooler && mkdir /var/log/vmpooler

WORKDIR /var/lib/vmpooler

ADD Gemfile* /var/lib/vmpooler/
RUN bundle install --system

RUN ln -s /opt/jruby/bin/jruby /usr/bin/jruby

RUN echo "deb http://httpredir.debian.org/debian jessie main" >/etc/apt/sources.list.d/jessie-main.list
RUN apt-get update && apt-get install -y redis-server && rm -rf /var/lib/apt/lists/*

COPY . /var/lib/vmpooler
COPY pooler_start.sh /pooler_start.sh
RUN chmod 777 /pooler_start.sh
ENV VMPOOLER_LOG /var/log/vmpooler.log
ENTRYPOINT /pooler_start.sh
