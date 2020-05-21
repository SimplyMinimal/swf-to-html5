#!/bin/bash
# This script is optional but useful to clean up a batch of dead SWF files
# REQUIRES IMAGEMAGICK to be installed in order to use 'identify'

PATH_TO_ASSETS=`pwd`/assets
echo "ASSETS: ${PATH_TO_ASSETS}"

for f in ${PATH_TO_ASSETS}/*.png; do
    PNG_TITLE=`basename -s .png ${f}`
    PNG_BASENAME=`basename ${f}`
    
    echo "Validating image for ${PNG_BASENAME}..."
    
    # Assumes that the number of colors found equal to 1 would mean that the thumbnail is all white or black
    # This most likely means it's a dead SWF so let's remove it
    if [[ `identify -verbose ./assets/${PNG_BASENAME}|grep "Colors:"|cut -f 2 -d ":"` -eq 1 ]]; then
        echo "Empty image found...removing SWF and PNG"
        rm ./assets/${PNG_TITLE}*
    fi
done;

