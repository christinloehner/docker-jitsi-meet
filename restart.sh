#!/bin/bash
 
DOCKERPATH=/server/jitsi.partei-mut.de
 
# Shutdown jitsi meet containers and remove images
cd $DOCKERPATH
docker-compose down --rmi all
 
# Delete configs and recreate folders
sudo rm -rf .jitsi-meet-cfg/
mkdir -p .jitsi-meet-cfg/{web/letsencrypt,transcripts,prosody,jicofo,jvb}
 
# Start Jitsi Meet
docker-compose up -d
sleep 10
 
# Customize
./customize.sh
 
# Set JVB Logging from INFO to WARNING
sudo sed -i 's/^.level=.*/.level=WARNING/' .jitsi-meet-cfg/jvb/logging.properties
docker restart jitsipartei-mutde_jvb_1

