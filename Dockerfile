FROM debian:stretch

MAINTAINER MielPops

# Pre-config
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install curl lib32gcc1 libmariadbclient-dev

EXPOSE 7775/tcp 7776/udp 7777/udp

# Server installation
WORKDIR /home 
RUN mkdir Steam
WORKDIR Steam
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -
RUN ./steamcmd.sh +login anonymous +force_install_dir ./OnsetServer/ +app_update 1204170 validate +quit
WORKDIR OnsetServer

# Dev configuration
ADD conf/server_config.json .
ADD packages packages
ADD plugins/ plugins/

ENTRYPOINT ["/bin/sh", "start_linux.sh"]
