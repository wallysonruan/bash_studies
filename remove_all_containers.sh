#!/bin/bash

set -e

# Get the all containers ID
containers_ids=($(docker ps -a | grep -v "CONTAINER" | awk '{print $1}'))

# Iterate over the list and remove all containers
for container_id in ${containers_ids[@]}; do
	docker container rm $container_id --force
done
