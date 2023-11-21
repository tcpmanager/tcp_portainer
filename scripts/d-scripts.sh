#!/bin/bash


function imageExists {
  local name_img="$1"
  local name_tag="$2"
  # shellcheck disable=SC2143
  if [ "$(docker images "$name_img:$name_tag" | awk '{print $1":"$2}' | grep -E '^'"$name_img:$name_tag"'$')" ]; then
    return 0
  else
    return 1
  fi
}

function networkExists {
  local name_net="$1"
  # shellcheck disable=SC2143
  if [ "$(docker network ls -f name="$name_net" | awk '{print $2}' | grep -E '^'"$name_net"'$')" ]; then
    return 0
  else
    return 1
  fi
}

function volumeExists {
  local name_vol="$1"
  # shellcheck disable=SC2143
  if [ "$(docker volume ls -f name="$name_vol" | awk '{print $NF}' | grep -E '^'"$name_vol"'$')" ]; then
    return 0
  else
    return 1
  fi
}

function containerExists {
  local name_cont="$1"
  # shellcheck disable=SC2143
  if [ "$(docker ps -a -f name="$name_cont" | awk '{print $NF}' | grep -E '^'"$name_cont"'$')" ]; then
    return 0
  else
    return 1
  fi
}

function databaseExists {
    local db_name_local="$1"
    local db_container_local="$2"
    local db_user="$3"
    # shellcheck disable=SC2155
    local out_put=$(docker exec -it "${db_container_local}" psql -U "${db_user}" postgres -c "select datname from pg_catalog.pg_database where datname='${db_name_local}';")
    if [[ ${out_put} = *"${1}"* ]]
    then
        return 0
    else
        return 1
    fi
}
