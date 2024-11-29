FROM ich777/debian-baseimage:bullseye_amd64

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-steamcmd-server"

RUN apt-get update && \
	apt-get -y install --no-install-recommends lib32gcc-s1 lib32stdc++6 lib32z1 dos2unix && \
	rm -rf /var/lib/apt/lists/*

#template
ENV GAME_ID="4020" 
ENV GAME_NAME="garrysmod"
ENV GAME_PARAMS="-secure +maxplayers 12"

ENV GAME_PORT=27015

ENV GAMEMODE="terrortown"
ENV START_MAP="ttt_minecraft_b5"
# TODO: Remove auth key and workshop collection
ENV AUTH_KEY=""
ENV WORKSHOP_COLLECTION=""

ENV MOUNT_CSSOURCE="true" 

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV CONFIG_DIR="${SERVER_DIR}/${GAME_NAME}/cfg"

ENV VALIDATE=""
ENV START_MAP=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""
ENV USER="steam"
ENV DATA_PERM=770

RUN mkdir $DATA_DIR && \
	mkdir $STEAMCMD_DIR && \
	mkdir $SERVER_DIR && \
	useradd -d $DATA_DIR -s /bin/bash $USER && \
	chown -R $USER $DATA_DIR && \
	ulimit -n 2048

ADD /scripts/ /opt/scripts/
ADD /config/ /opt/config/
RUN chmod -R 770 /opt/scripts/

# RUN dos2unix /opt/scripts/start.sh

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
