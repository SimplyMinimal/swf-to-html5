#!/bin/bash
PATH_TO_RUFFLE_BASE=~/ruffle
PATH_TO_ASSETS=`pwd`/assets

echo "RUFFLE_BASE: ${PATH_TO_RUFFLE_BASE}" 
echo "ASSETS: ${PATH_TO_ASSETS}"

cd ${PATH_TO_RUFFLE_BASE}

for f in ${PATH_TO_ASSETS}/*.swf; do
    SWF_TITLE=`basename -s .swf ${f}`
    SWF_BASENAME=`basename ${f}`
    
    echo "Generating file for ${SWF_BASENAME}..."
    IMG_PATH=`find ${PATH_TO_ASSETS} -name \*${SWF_BASENAME}.jpg -o -name \*${SWF_BASENAME}.png -o -name \*${SWF_BASENAME}.gif`
    echo ${IMG_PATH}
    if [[ -f ${IMG_PATH} && ! -z ${IMG_PATH} ]]; then
        echo "Image exists. Using ${IMG_PATH}..."
    else
        echo "Does not exist. Generating thumbnail..."
        cargo run --package=exporter -- ${PATH_TO_ASSETS}/${SWF_BASENAME} ${PATH_TO_ASSETS}/${SWF_BASENAME}.png --skipframes 100
    fi
done;

