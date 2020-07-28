#!/bin/bash
set -eu

# Variables
NC='\033[0m' # No Color
Light_Green='\033[1;32m' 
STARTMSG="${Light_Green}[ENTRYPOINT_MISP_MODULES]${NC}"
WORKDIR=${WORKDIR:-"/usr/local/src/misp-modules"}
MISP_MODULES_BINARY="${WORKDIR}/venv/bin/misp-modules"
DEBUG=""

# Functions
echo (){
    command echo -e "$STARTMSG $*"
}

# Environment Variables
MISP_MODULES_DEBUG=${MISP_MODULES_DEBUG:-"false"}

#
#   MAIN
#


# Check if debugging mode should be enabled
[ "$MISP_MODULES_DEBUG" = "true" ] && DEBUG="-d"

ping_redis(){
    (exec 9<>"/dev/tcp/$1/$2" && command echo -e "PING\r" >&9 && head -n 1 <&9 | tr -d '\015')
}

check_redis(){
    # Test when Redis is ready
    while ! [ "$(ping_redis ${REDIS_BACKEND} ${REDIS_PORT})" = "+PONG" ]; do
        echo "Wait for Redis..."
        sleep 2
    done
}

echo "Check if Redis is ready..." && check_redis

# check if a command parameter exists and start misp-modules
if [ $# = 0 ]
then
    # If no cmd parameter is set
    echo "Start MISP Modules" && $MISP_MODULES_BINARY $DEBUG -l 0.0.0.0  > /dev/stdout 2> /dev/stderr
else
    # If cmd parameter is set
    echo "Start MISP Modules" && $MISP_MODULES_BINARY $DEBUG -l 0.0.0.0 > /dev/stdout 2> /dev/stderr &
    exec "$@"
fi
