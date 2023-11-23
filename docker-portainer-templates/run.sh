#!/bin/bash
set -e
export PT_PORT="9003"
export PT_IMAGE="portainer-templates"
export PT_NAME="portainer-tmpls"

while getopts n:d:p:c: flag
do
    case "${flag}" in
        n) PORTAINER_NETWORK="${OPTARG}";;                
        d) PORTAINER_DIR="${OPTARG}";;        
        p) PT_PORT="${OPTARG}";;    
        c) P_COMMAND="${OPTARG}";;        
    esac
done

PT_AREA="$PORTAINER_DIR/$PT_NAME"
PT_DIR="$PT_AREA/docker-image"
if [ "${P_COMMAND}" == "start" ];then
    mkdir -p "$PT_AREA"
    cp -r docker-image "$PT_AREA"    
    # git clone https://github.com/lissy93/portainer-templates.git "$PT_AREA"
    docker build --rm -t "$PT_IMAGE" "$PT_DIR/."
    docker run --name="$PT_NAME" --network="$PORTAINER_NETWORK" --restart=always -d -p "$PT_PORT:80" "$PT_IMAGE"
# cd portainer-templates
# docker build -t portainer-templates .
# docker run -d -p "8080:80" portainer-templates
elif [ "${P_COMMAND}" == "restart" ];then
    rm -r -f "$PT_DIR"/lib
    cp -r docker-image/sources "$PT_DIR"
    cp -r docker-image/scripts "$PT_DIR"
    cp -r docker-image/Makefile "$PT_DIR"
    cp -r docker-image/sources.csv "$PT_DIR"
    cd "$PT_DIR"    
    make combine
    docker cp "$PT_DIR"/templates.json "$PT_NAME":/usr/share/nginx/html/templates.json
    docker restart "$PT_NAME"
elif [ "${P_COMMAND}" == "rebuild" ];then
    cp -r docker-image "$PT_AREA"   
    cd "$PT_DIR"
    docker rm -f "$PT_NAME"
    docker rmi -f "$PT_IMAGE"
    
    make
    docker build --rm -t "$PT_IMAGE" "$PT_DIR/."
    docker run --name="$PT_NAME" --network="$PORTAINER_NETWORK" --restart=always -d -p "$PT_PORT:80" "$PT_IMAGE"
fi