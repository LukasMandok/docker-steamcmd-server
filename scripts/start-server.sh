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

# Create missing folders:
mkdir -p ${CONFIG_DIR}

mkdir -p "${GMOD_DIR}/data"
mkdir -p "${GMOD_DIR}/addons"
chmod ${DATA_PERM} "${GMOD_DIR}/data" "${GMOD_DIR}/addons"


if [ "${MOUNT_CSSOURCE}" == "true" ]; then
    echo "--- Installing Counter-Strike: Source resources ---"
    run_steamcmd "232330" "${SERVER_DIR}/cssource" "true"

    echo "--- Copying mount.cfg ---"
    cp /opt/config/general/mount.cfg ${CONFIG_DIR}/mount.cfg
fi

if [ "${GAME_NAME}" == "garrysmod" ] && [ ! -f "$MARKER_FILE" ]; then
    echo "--- COPY over default config files ---"
    
    cp /opt/config/garrysmod/cfg/server.cfg ${CONFIG_DIR}/server.cfg

    cp /opt/config/garrysmod/cfg/autoexec.cfg ${CONFIG_DIR}/autoexec.cfg

    cp /opt/config/garrysmod/maps.txt ${SERVER_DIR}/maps.txt

    cp -r /opt/config/garrysmod/data/* ${GMOD_DIR}/data/
    cp -r /opt/config/garrysmod/addons/* ${GMOD_DIR}/addons/

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

touch $MARKER_FILE

echo "---Server ready---"

## RANDOM MAP SELECTION

if [ -z ${START_MAP} ]; then
    echo " --- Select a random map ---"
    MAPS_FILE="${SERVER_DIR}/maps.txt"
    MAPS=($(grep -v '^#' "$MAPS_FILE"))
    NUM_MAPS=${#MAPS[@]}
    if [ $NUM_MAPS -eq 0 ]; then
        echo "Warning: No valid maps found in $MAPS_FILE"
        START_MAP="ttt_minecraft_b5"  # Default fallback map
    else
        START_MAP=${MAPS[$RANDOM % $NUM_MAPS]}
    fi
fi

echo "Selected map: $START_MAP"

# Add additional game parameters
game_parameters="${GAME_PARAMS} -game ${GAME_NAME} +gamemode ${GAMEMODE} +map ${START_MAP}"
game_parameters="${game_parameters} -console +port ${GAME_PORT}"

echo "WORKSHOP_COLLECTION is: '${WORKSHOP_COLLECTION}'"
echo "AUTH_KEY is: '${AUTH_KEY}'"

if [[ -n "${WORKSHOP_COLLECTION}" && -n "${AUTH_KEY}" ]]; then
    echo "---Adding Workshop Collection: ${WORKSHOP_COLLECTION} and AUTH_KEY: ${AUTH_KEY}---"
    game_parameters="${game_parameters} -authkey ${AUTH_KEY} +host_workshop_collection ${WORKSHOP_COLLECTION}"
fi

echo "---Start Server---"
echo "!!!! game parameters: ${game_parameters}"

cd ${SERVER_DIR}

exec script -q -c "${SERVER_DIR}/srcds_run ${game_parameters}" /dev/null