#!/bin/bash

set -e

# Get the all containers ID
images_ids=($(docker images | grep -v "IMAGE" | awk '{print $3}'))


# Iterate over the list and remove all images
for image_id in ${images_ids[@]}; do
	docker rmi $image_id --force
done
