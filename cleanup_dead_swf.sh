#!/bin/bash
PATH_TO_ASSETS=`pwd`/assets
echo "ASSETS: ${PATH_TO_ASSETS}"

for f in ${PATH_TO_ASSETS}/*.png; do
    PNG_TITLE=`basename -s .png ${f}`
    PNG_BASENAME=`basename ${f}`
    
    echo "Validating image for ${PNG_BASENAME}..."
    
    if [[ `identify -verbose ./assets/${PNG_BASENAME}|grep "Colors:"|cut -f 2 -d ":"` -eq 1 ]]; then
        echo "Empty image found...removing SWF and PNG"
        rm ./assets/${PNG_TITLE}*
    fi
done;

