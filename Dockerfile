FROM ubuntu:xenial
MAINTAINER Toon Leijtens <toonleijtens@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
    apt-get -y -qq upgrade &&\
    apt-get -y -qq install apt-utils &&\
    apt-get -y -qq install software-properties-common

# install prerequisites
RUN apt-get update &&\
    apt-get -y -qq install nodejs &&\
    apt-get -y -qq install nodejs-legacy &&\
    apt-get -y -qq install npm &&\
    apt-get -y -qq install git

# get the appi
RUN cd &&\
    git clone https://github.com/cubedro/eth-net-intelligence-api.git /eth-net-intelligence-api

COPY artifacts/app.json /eth-net-intelligence-api

# build the api
RUN cd /eth-net-intelligence-api &&\
    npm install -d &&\
    npm install pm2 -g

EXPOSE 30303
EXPOSE 3000
EXPOSE 8545
EXPOSE 8546

WORKDIR /eth-net-intelligence-api

CMD [ "pm2", "start", "--no-daemon", "app.json" ]
