#!/bin/bash

DOCKERPATH=/server/jitsi.partei-mut.de

# Shutdown jitsi meet containers and remove images
cd $DOCKERPATH
/usr/bin/docker-compose down --rmi all

# Delete configs and recreate folders
/usr/bin/sudo /usr/bin/rm -rf .jitsi-meet-cfg
/usr/bin/mkdir -p .jitsi-meet-cfg/{web/letsencrypt,transcripts,prosody,jicofo,jvb}

# Start Jitsi Meet
/usr/bin/docker-compose up -d
/usr/bin/sleep 10

# Customize
${DOCKERPATH}/customize.sh

# Set JVB Logging from INFO to WARNING
/usr/bin/sudo /usr/bin/sed -i 's/^.level=.*/.level=WARNING/' .jitsi-meet-cfg/jvb/logging.properties
/usr/bin/docker restart jitsipartei-mutde_jvb_1

