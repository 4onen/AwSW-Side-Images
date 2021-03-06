#!/bin/sh

EXIT_CODE=0

for IMAGE_PATH in $(./list.awk side_images.rpy.pre | grep "^[^#]")
do
    if ! test -f ../../$IMAGE_PATH -o -f ../**/resource/$IMAGE_PATH
    then
        EXIT_CODE=1
        echo "$IMAGE_PATH does not exist!"
    fi
done

exit $EXIT_CODE