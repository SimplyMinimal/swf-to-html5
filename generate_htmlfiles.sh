#!/bin/bash
CLEAN_UP=1 #Set to 0 to disable

# Create assets folder if it doesn't exist
if [ ! -d "./assets" ]; then
    mkdir -p "./assets"
    chmod 600 "./assets"
    echo "assets folder created. Go ahead and dump .swf files in this folder and re-run this script"
    exit 0
fi

if [ ${CLEAN_UP} -eq 1 ]; then
    echo "Cleaning up old files..."
    rm ./assets/*.html
fi


getimage(){
    while [[ "${RANDOM_IMAGE}" = "${LAST_IMAGE_USED}" ]]; do
        RANDOM_IMAGE=`ls images/ | shuf -n 1`
    done;
    LAST_IMAGE_USED=${RANDOM_IMAGE}
}
getimage
LAST_IMAGE_USED=${RANDOM_IMAGE}

add_card(){
    # First Parameter: Name
    # Second Parameter: URL
    # Third Parameter: IMG
    # Fourth Parameter: white/black
    NAME="$1"
    URL="$2"
    if [ -z "$3" ]; then
        getimage
        IMAGE_URL=images/${RANDOM_IMAGE}
    else
        IMAGE_URL="$3"
    fi
    if [ -z "$4" ]; then
        TITLE_COLOR=white
    else
        TITLE_COLOR="$4"
    fi
    echo "Adding ${TITLE}: ${URL} : ${IMAGE_URL}"
cat <<EOF >> index.html
        <div class="card ${RANDOM}" onclick="location.href='${URL}';">
                <div class="card_image">
                    <img src="${IMAGE_URL}" />
                    <div class="card_title title-${TITLE_COLOR}">
                        <p>${NAME}</p>
                    </div>
                </div>
        </div>

EOF
}

cat <<EOF > index.html
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tesla Games and Apps</title>
    <link rel="stylesheet" type="text/css" href="css/auroral2.css" />
    <link rel="stylesheet" href="css/cards.css">
</head>

<body>
    <div class="auroral-info">
        <h1>Tesla Games</h1>
        <a href="#northern" class="filter-link"> Northern</a>
        <a href="#northern-intense" class="filter-link"> Northern Intense</a>
        <a href="#northern-dimmed" class="filter-link"> Northern Dimmed</a>
        <a href="#northern-dusk" class="filter-link"> Northern Dusk</a>
        <a href="#northern-warm" class="filter-link"> Northern Warm</a>
        <a href="#agrabah" class="filter-link"> Agrabah</a>

        <div class="cards-list">

EOF

add_card "Word Wipe" "https://www.crazygames.com/game/word-wipe" "https://images.crazygames.com/games/word-wipe/thumb-1564675416346.png" "black"
add_card "There Is No Game" "https://www.albinoblacksheep.com/games/html5/there-is-no-game/" "images/landscape.jpg"
add_card "HTML5 Games" "https://www.albinoblacksheep.com/games/" "images/blue.gif"
LAST_IMAGE_USED="images/blue.gif"

CURDIR=`pwd`
for f in ./assets/*.swf; do
    SWF_TITLE=`basename -s .swf ${f}`
    SWF_BASENAME=`basename ${f}`
    
    echo "Generating file for ${f}..."
    
    # Output Fullscreen SWF page
cat <<EOF > ${f}.html
<html>
    <body>
        <embed src="../${f}" width="100%" height="100%"> </embed>
        <script src="../ruffle_web_latest//ruffle.js"></script>
    </body>
</html>
EOF
    
    # Add to Main Page
    
    IMG_PATH=`find assets -name \*${SWF_BASENAME}.jpg -o -name \*${SWF_BASENAME}.png -o -name \*${SWF_BASENAME}.gif`
    if [[ -f ${IMG_PATH} && ! -z ${IMG_PATH} ]]; then
        echo "Image exists. Using ${IMG_PATH}..."
cat <<EOF >> index.html
    <div class="card 1" onclick="location.href='./assets/${SWF_BASENAME}.html';">
            <div class="card_image">
                <img src="${IMG_PATH}" />
            </div>
    </div>
EOF
    else
        echo "Using random image..."
        getimage
cat <<EOF >> index.html
    <div class="card 1" onclick="location.href='./assets/${SWF_BASENAME}.html';">
            <div class="card_image">
                <img src="images/${RANDOM_IMAGE}" />
                 <div class="card_title title-white">
                    <p>${SWF_TITLE}</p>
                </div>
            </div>
    </div>
EOF
    fi
    
done;


# Wrap up main page
cat <<EOF >> index.html
  </div>
    </div>
    <!-- Theme Selector -->
    <div class="container">
        <div id="northern" class="auroral auroral-northern"></div>
        <div id="northern-intense" class="auroral auroral-northern-intense"></div>
        <div id="northern-dimmed" class="auroral auroral-northern-dimmed"></div>
        <div id="northern-dusk" class="auroral auroral-northern-dusk"></div>
        <div id="northern-warm" class="auroral auroral-northern-warm"></div>
        <div id="agrabah" class="auroral auroral-agrabah"></div>
        <div class="auroral-stars"></div>
    </div>
</body>

</html>
EOF