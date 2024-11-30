# FROM ich777/debian-baseimage:bullseye_amd64
FROM debian:stable-slim

LABEL org.opencontainers.image.authors="admin@minenet.at"
LABEL org.opencontainers.image.source="https://github.com/ich777/docker-steamcmd-server"

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get -y install --no-install-recommends \
        lib32gcc-s1 \
        lib32stdc++6 \
        lib32z1 \
        dos2unix \
        lib32ncurses6 \
        lib32tinfo6 \
        lib32readline8 \
        wget \
        tar \
        expect \
        ca-certificates \
        locales && \                          
    rm -rf /var/lib/apt/lists/* && \
    # Set locale
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# Game environment variables
ENV GAME_ID="4020" \
    GAME_NAME="garrysmod" \
    GAME_PARAMS="+maxplayers 12" \
    GAME_PORT=27015 \
    GAMEMODE="terrortown" \
    START_MAP="ttt_minecraft_b5" \
    MOUNT_CSSOURCE="false"

ENV AUTH_KEY=""
ENV WORKSHOP_COLLECTION=""

# Directory structure
    
ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GMOD_DIR="${SERVER_DIR}/${GAME_NAME}"
ENV CONFIG_DIR="${SERVER_DIR}/${GAME_NAME}/cfg"
ENV STEAM_DIR="{DATA_DIR}/Steam"

# User settings
ENV VALIDATE="" \
    START_MAP="" \
    UMASK=000 \
    UID=99 \
    GID=100 \
    USERNAME="" \
    PASSWRD="" \
    USER="steam" \
    DATA_PERM=770

# Create directory structure
RUN mkdir -p ${DATA_DIR} \
            ${STEAMCMD_DIR} \
            ${SERVER_DIR} \
            ${CONFIG_DIR} \
            ${STEAM_DIR}/logs && \
    useradd -d ${DATA_DIR} -s /bin/bash ${USER} && \
    chown -R ${USER}:${GID} ${DATA_DIR} && \
    chmod -R ${DATA_PERM} ${DATA_DIR}

ADD /scripts/ /opt/scripts/
ADD /config/ /opt/config/
RUN chown -R ${USER}:${GID} /opt/ && \
    chmod -R ${DATA_PERM} /opt/

# RUN dos2unix /opt/scripts/start.sh

#Server Start
ENTRYPOINT ["/opt/scripts/start.sh"]
