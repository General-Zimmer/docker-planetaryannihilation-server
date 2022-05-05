FROM ich777/debian-baseimage

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-planetaryannihilation-server"

RUN echo "deb http://deb.debian.org/debian bullseye main" >> /etc/apt/sources.list && \
	apt-get update && \
	apt-get -y install --no-install-recommends unzip golang libcurl4-gnutls-dev libsdl2-2.0-0 libgl1-mesa-glx libstdc++6 gcc-9 && \
	rm -rf /var/lib/apt/lists/*

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
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV DATA_PERM=770
ENV USER="PA"

RUN mkdir $DATA_DIR && \
	mkdir $SERVER_DIR && \
	useradd -d $SERVER_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]