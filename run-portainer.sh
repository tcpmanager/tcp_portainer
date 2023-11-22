#!/bin/bash

set -e
export P_COMMAND="restart"
# direnv allow .

source $(dirname "$0")/scripts/d-scripts.sh

while getopts n:v:t:p:d:c:i:l:q:r:s: flag
do
    case "${flag}" in
        n) PORTAINER_NETWORK="${OPTARG}";;
        v) PORTAINER_VOLUME="${OPTARG}";;
        t) PORTAINER_TARGET="${OPTARG}";;
        p) PORT_LEGACY_PORT="${OPTARG}";;
        q) PORT_SSL_PORT="${OPTARG}";;
        r) PORT_AGENT_PORT="${OPTARG}";;
        s) PORT_TUNNEL_PORT="${OPTARG}";;
        d) PORTAINER_DIR="${OPTARG}";;        
        c) P_COMMAND="${OPTARG}";;
        i) PORTAINER_IMAGE="${OPTARG}";;
        l) PORTAINER_IMAGE_TAG="${OPTARG}";;
    esac
done

echo ""
echo "... Configurando portainer..."
echo ""
currentDir="$(pwd)"
cd docker-portainer
bash run.sh -n "$PORTAINER_NETWORK" -v "$PORTAINER_VOLUME" -t "$PORTAINER_TARGET" -r "$PORT_AGENT_PORT" -s "$PORT_TUNNEL_PORT" -p "$PORT_LEGACY_PORT" -q "$PORT_SSL_PORT" -d "$PORTAINER_DIR" -c "$P_COMMAND" -i "$PORTAINER_IMAGE" -l "$PORTAINER_IMAGE_TAG"
cd "$currentDir"

# direnv allow
# ./run-portainer.sh -c rebuild