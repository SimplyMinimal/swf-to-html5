#!/bin/bash
DOWNLOAD_URL="https://ruffle-rs.s3-us-west-1.amazonaws.com/builds/web/ruffle_web_latest.zip"
mkdir "ruffle_web_latest"
cd ruffle_web_latest
echo "Creating temp file..."
TMPFILE=`mktemp`
PWD=`pwd`
echo "Downloading..."
wget "${DOWNLOAD_URL}" -O $TMPFILE
echo "Extract..."
unzip -d $PWD $TMPFILE
rm $TMPFILE