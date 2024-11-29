#!/bin/bash

MARKER_FILE="${DATA_DIR}/.initialized"

run_steamcmd() {
    local app_id=${1:-""}
    local force_install_dir=${2:-${SERVER_DIR}}
    local validate=${3:-${VALIDATE}}
    local authenticate=${4:-"true"}

    local parameters=""

    # add a install directory if force_install_dir is not an empty string
    if [ -n "$force_install_dir" ]; then
        local parameters="$parameters +force_install_dir $force_install_dir"  
    fi

    # use authentication, if username and password are provided and authenticate is not explicitly set to false
    if [ -n "$USERNAME" ] && [ "$authenticate" != "false" ]; then
        parameters="$parameters +login $USERNAME $PASSWRD"
    else
        parameters="$parameters +login anonymous"
    fi

    # add app_update and the app id, if app_id is not an empty string
    if [ -n "$app_id" ]; then
        parameters="$parameters +app_update $app_id"
    fi

    # add validate, if validate is explicitly set to true, default from env var
    if [ "$validate" == "true" ]; then
        parameters="$parameters  validate"
    fi

    ${STEAMCMD_DIR}/steamcmd.sh $parameters +quit
}

if [ ! -f ${STEAMCMD_DIR}/steamcmd.sh ]; then
    echo "SteamCMD not found!"
    wget -q -O ${STEAMCMD_DIR}/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz 
    tar --directory ${STEAMCMD_DIR} -xvzf /serverdata/steamcmd/steamcmd_linux.tar.gz
    rm ${STEAMCMD_DIR}/steamcmd_linux.tar.gz
fi

echo "--- Update SteamCMD ---"
run_steamcmd "" ""


echo "--- Update Server ---  Installing game id: ${GAME_ID}"
run_steamcmd "${GAME_ID}"


if [ "${MOUNT_CSSOURCE}" == "true" ]; then
    echo "--- Installing Counter-Strike: Source resources ---"
    run_steamcmd "232330" "${SERVER_DIR}/cssource" "true"

    # echo "---Mounting Counter-Strike: Source resources---"
    # if [ ! -d ${SERVER_DIR}/cstrike ]; then
    #     mkdir ${SERVER_DIR}/cstrike
    # fi
    # ln -s ${DATA_DIR}/cssource/cstrike ${SERVER_DIR}/cstrike

    echo "---Copying mount.cfg---"
    if [ ! -d ${SERVER_DIR}/${GAME_NAME}/cfg ]; then
        # mkdir -p ${SERVER_DIR}/${GAME_NAME}/cfg
        mkdir -p ${CONFIG_DIR}
    fi
    cp /opt/config/general/mount.cfg ${CONFIG_DIR}/mount.cfg
fi

if [ "${GAME_NAME}" == "garrysmod" ] && [ ! -f "$MARKER_FILE" ]; then
    echo "--- COPY over default config files ---"
    
    cp /opt/config/garrysmod/cfg/server.cfg ${CONFIG_DIR}/server.cfg

    cp /opt/config/garrysmod/cfg/autoexec.cfg ${CONFIG_DIR}/autoexec.cfg

    cp /opt/config/garrysmod/maps.txt ${SERVER_DIR}/maps.txt

    cp -r /opt/config/garrysmod/data/* ${CONFIG_DIR}/data/
else 
    echo "--- Configuration files already exist, skipping ---"
fi

echo "---Prepare Server---"
if [ ! -f ${DATA_DIR}/.steam/sdk32/steamclient.so ]; then
	if [ ! -d ${DATA_DIR}/.steam ]; then
    	mkdir ${DATA_DIR}/.steam
    fi
	if [ ! -d ${DATA_DIR}/.steam/sdk32 ]; then
    	mkdir ${DATA_DIR}/.steam/sdk32
    fi
    cp -R ${STEAMCMD_DIR}/linux32/* ${DATA_DIR}/.steam/sdk32/
fi
chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

## RANDOM MAP SELECTION

if [ -z ${START_MAP} ]; then
    echo " --- Select a random map ---"
    MAPS_FILE="${SERVER_DIR}/maps.txt"
    MAPS=($(cat $MAPS_FILE))
    NUM_MAPS=${#MAPS[@]}
    START_MAP=${MAPS[$RANDOM % $NUM_MAPS]}
fi

echo "Selected map: $START_MAP"



# Add additional game parameters
game_parameters="${GAME_PARAMS} +gamemode ${GAMEMODE} +map ${START_MAP}"

# if [ -n "${WORKSHOP_COLLECTION}" ] && [ -n "${AUTH_KEY}" ]; then
#     game_parameters="${game_parameters} -authkey ${AUTH_KEY} +host_workshop_collection ${WORKSHOP_COLLECTION}"
# fi

touch $MARKER_FILE

##### VERIFICATION #####

# Add these checks and delays before starting the server
echo "---Verify Steam setup---"
if [ ! -f ${DATA_DIR}/.steam/sdk32/steamclient.so ]; then
    echo "Steam client library missing!"
    exit 1
fi

# Add small delay to ensure Steam API is ready
echo "---Waiting for Steam API initialization---"
sleep 5

# Verify LD_LIBRARY_PATH includes Steam directories
export LD_LIBRARY_PATH="${DATA_DIR}/.steam/sdk32:${SERVER_DIR}:${LD_LIBRARY_PATH}"

##### STARTING SERVER #####

ls -l ${DATA_DIR}/.steam/sdk32/steamclient.so
echo "---Start Server---"
cd ${SERVER_DIR}
${SERVER_DIR}/srcds_run -game ${GAME_NAME} ${game_parameters} -console +port ${GAME_PORT} 