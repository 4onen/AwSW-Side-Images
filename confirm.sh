#!/bin/sh

for IMAGE_PATH in $(./list.awk side_images.rpy.pre | grep "^[^#]")
do
    if ! test -f ../../$IMAGE_PATH -o -f ../**/resource/$IMAGE_PATH
    then
        echo "$IMAGE_PATH does not exist!"
    fi
done