#!/bin/bash

set -e

# export P_COMMAND="start"

source ../scripts/d-scripts.sh

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
echo "- Direccion Base de portainer"
echo "*** $PORTAINER_DIR"
echo ""
echo "- Nombre container"
echo "*** $PORTAINER_TARGET"
echo ""
echo "- Puerto http de portainer"
echo "*** $PORTAINER_PORT"
echo ""
# echo "- Existe network ${PORTAINER_NETWORK}???"
if  ! networkExists "$PORTAINER_NETWORK"; then
  # echo "*** Network no existe...!!!"
  echo "*** Creando network $PORTAINER_NETWORK"
else
  echo "*** Network $PORTAINER_NETWORK existe."
fi
echo ""
# echo "- Existe volumen ${PORTAINER_VOLUME}???"
if  ! volumeExists "$PORTAINER_VOLUME"; then
  # echo "*** Volumen no existe...!!!"
  echo "*** Creando volumen $PORTAINER_VOLUME"
else
  echo "*** volumen $PORTAINER_VOLUME existe."
fi

mkdir -p "$PORTAINER_DIR"
mkdir -p "$PORTAINER_AREA"
mkdir -p "$PORTAINER_AREA/$PORTAINER_VOLUME"

rm -f "$PORTAINER_AREA/docker-compose.yml"
rm -f "$PORTAINER_AREA/.env"
cp ./docker-compose.yml "$PORTAINER_AREA"/.
chmod u+x "$PORTAINER_AREA"/docker-compose.yml
{
  echo "PORT_AGENT_PORT=$PORT_AGENT_PORT";
  echo "PORT_LEGACY_PORT=$PORT_LEGACY_PORT";
  echo "PORT_TUNNEL_PORT=$PORT_TUNNEL_PORT";
  echo "PORT_SSL_PORT=$PORT_SSL_PORT";
  echo "PORTAINER_VOLUME=$PORTAINER_VOLUME";
  echo "PORTAINER_NETWORK=$PORTAINER_NETWORK";
  echo "PORTAINER_AREA=$PORTAINER_AREA";
  echo "PORTAINER_TARGET=$PORTAINER_TARGET";
  echo "PORTAINER_IMAGE=$PORTAINER_IMAGE";
  echo "PORTAINER_IMAGE_TAG=$PORTAINER_IMAGE_TAG";
} >> "$PORTAINER_AREA"/.env

echo "  Stop portainer "

# echo "$PORTAINER_IMAGE:$PORTAINER_IMAGE_TAG"

if containerExists "$PORTAINER_TARGET"; then
  docker stop "$PORTAINER_TARGET"  
  docker rm "$PORTAINER_TARGET"
fi
if [ "$P_COMMAND" == 'rebuild' ]; then
  if imageExists "$PORTAINER_IMAGE" "$PORTAINER_IMAGE_TAG" ; then
    echo "  Delete image"
    docker rmi "$PORTAINER_IMAGE:$PORTAINER_IMAGE_TAG"
    docker pull "$PORTAINER_IMAGE:$PORTAINER_IMAGE_TAG"
  fi
fi
docker-compose -f "$PORTAINER_AREA"/docker-compose.yml up -d
