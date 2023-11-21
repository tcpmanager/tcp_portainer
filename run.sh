#!/bin/bash

set -e
# source $(dirname "$0")/scripts/d-scripts.sh

export PT_PORT="9003"
export PT_IMAGE="portainer-templates"
export PT_NAME="portainer-tmpls"
export P_COMMAND=""

while getopts n:p:d:c: flag
do
    case "${flag}" in
        n) PORTAINER_NETWORK="${OPTARG}";;                
        p) PT_PORT="${OPTARG}";;                
        d) PORTAINER_DIR="${OPTARG}";;        
        c) P_COMMAND="${OPTARG}";;        
    esac
done
currentDir="$(pwd)"
cd docker-portainer-templates
bash run.sh -n "$PORTAINER_NETWORK" -p "$PT_PORT" -d "$PORTAINER_DIR" -c "$P_COMMAND"
cd "$currentDir"


# ./run.sh -c restart