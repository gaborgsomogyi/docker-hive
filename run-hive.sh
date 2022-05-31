#!/bin/bash

current_dir=$(pwd)

. $current_dir/network.sh

NETWORK=delegation-token-network
create_network_if_not_exists ${NETWORK}
docker run -it --hostname=hive --name=hive --network ${NETWORK} --rm --mount type=bind,source=$HOME/share,target=/share -p 9083:9083 gaborgsomogyi/hive:latest
