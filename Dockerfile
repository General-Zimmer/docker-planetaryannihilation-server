FROM ubuntu

MAINTAINER ich777

RUN apt-get update
RUN apt-get -y install wget unzip golang libcurl4-gnutls-dev libsdl2-2.0-0 libgl1-mesa-glx

ENV DATA_DIR="/serverdata"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_PARAMS=""
ENV GAME_PORT=20545
ENV GAME_STREAM="stable"
ENV GAME_MODE="lobby"
ENV SERVER_NAME="DockerServer"
ENV SERVER_PWD="Docker"
ENV MAX_PLAYERS=12
ENV UPDATE_ON_START=""
ENV PA_ACC_NAME=""
ENV PA_ACC_PWD=""
ENV UID=99
ENV GID=100

RUN mkdir $DATA_DIR
RUN mkdir $SERVER_DIR
RUN useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID PA
RUN chown -R PA $DATA_DIR

RUN ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
RUN chown -R PA /opt/scripts

USER PA

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]
