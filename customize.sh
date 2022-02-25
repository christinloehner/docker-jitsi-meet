#!/bin/bash

# Welcome Page
/usr/bin/docker cp welcomePageAdditionalCard.html jitsipartei-mutde_web_1:/usr/share/jitsi-meet/static/
/usr/bin/docker cp welcomePageAdditionalContent.html jitsipartei-mutde_web_1:/usr/share/jitsi-meet/static/
/usr/bin/docker cp close2.html jitsipartei-mutde_web_1:/usr/share/jitsi-meet/static/
/usr/bin/docker cp welcome-background.png jitsipartei-mutde_web_1:/usr/share/jitsi-meet/images/
/usr/bin/docker cp favicon.ico jitsipartei-mutde_web_1:/usr/share/jitsi-meet/images/

/usr/bin/sudo /usr/bin/sed -i "s/APP_NAME: 'Jitsi Meet',/APP_NAME: 'Videobridge der Partei mut',/" .jitsi-meet-cfg/web/interface_config.js
/usr/bin/sudo /usr/bin/sed -i "s/DISPLAY_WELCOME_PAGE_ADDITIONAL_CARD: .*,/DISPLAY_WELCOME_PAGE_ADDITIONAL_CARD: true,/" .jitsi-meet-cfg/web/interface_config.js
/usr/bin/sudo /usr/bin/sed -i "s/DISPLAY_WELCOME_PAGE_CONTENT: .*,/DISPLAY_WELCOME_PAGE_CONTENT: true,/" .jitsi-meet-cfg/web/interface_config.js
/usr/bin/sudo /usr/bin/sed -i "s/DISPLAY_WELCOME_FOOTER: .*,/DISPLAY_WELCOME_FOOTER: false,/" .jitsi-meet-cfg/web/interface_config.js
/usr/bin/sudo /usr/bin/sed -i "s/MOBILE_APP_PROMO: true,/MOBILE_APP_PROMO: false,/" .jitsi-meet-cfg/web/interface_config.js


/usr/bin/sudo /usr/bin/sed -i "s/jitsi-meet\.example\.com/jitsi.partei-mut.de/" .jitsi-meet-cfg/web/config.js
/usr/bin/sudo /usr/bin/sed -i "s/jitsi-meet\.example\.com/jitsi.partei-mut.de/" .jitsi-meet-cfg/web/interface_config.js

# Watermark
# /usr/bin/sudo /usr/bin/sed -i 's/SHOW_JITSI_WATERMARK: true/SHOW_JITSI_WATERMARK: false/' .jitsi-meet-cfg/web/interface_config.js
/usr/bin/sudo /usr/bin/sed -i "s/DEFAULT_LOGO_URL: '.*',/DEFAULT_LOGO_URL: 'https:\/\/www.mut-bayern.de\/wp-content\/uploads\/2019\/04\/cropped-cropped-mut_Partei_Logo_WEB_485x231px.png',/" .jitsi-meet-cfg/web/interface_config.js
/usr/bin/sudo /usr/bin/sed -i "s/DEFAULT_WELCOME_PAGE_LOGO_URL: '.*',/DEFAULT_WELCOME_PAGE_LOGO_URL: 'https:\/\/www.mut-bayern.de\/wp-content\/uploads\/2019\/04\/cropped-cropped-mut_Partei_Logo_WEB_485x231px.png',/" .jitsi-meet-cfg/web/interface_config.js
/usr/bin/sudo /usr/bin/sed -i "s/JITSI_WATERMARK_LINK: '.*',/JITSI_WATERMARK_LINK: '',/" .jitsi-meet-cfg/web/interface_config.js

# Disable third party requests (gravatar.com)
/usr/bin/sudo /usr/bin/sed -i "s#// disableThirdPartyRequests: false,#disableThirdPartyRequests: true,#" .jitsi-meet-cfg/web/config.js

# Disable generated room names
/usr/bin/sudo /usr/bin/sed -i "s#GENERATE_ROOMNAMES_ON_WELCOME_PAGE: true,#GENERATE_ROOMNAMES_ON_WELCOME_PAGE: false,#" .jitsi-meet-cfg/web/interface_config.js

# Set own STUN server
/usr/bin/sudo /usr/bin/sed -i "s#// { urls: 'stun:jitsi-meet.example.com:3478#{ urls: 'stun:relay.adminforge.de:443#" .jitsi-meet-cfg/web/config.js
/usr/bin/sudo /usr/bin/sed -i 's/meet-jit-si-turnrelay.jitsi.net:443/relay2.adminforge.de:443/' .jitsi-meet-cfg/web/config.js

# Auto Language
/usr/bin/sudo /usr/bin/sed -i 's/LANG_DETECTION: false/LANG_DETECTION: true/' .jitsi-meet-cfg/web/interface_config.js
/usr/bin/sudo /usr/bin/sed -i "s#// defaultLanguage: 'en'#defaultLanguage: 'de'#" .jitsi-meet-cfg/web/config.js

# Set Resolution
/usr/bin/sudo /usr/bin/sed -i 's#// resolution: 720#resolution: 720#' .jitsi-meet-cfg/web/config.js
if [ $(grep "    constraints: {" .jitsi-meet-cfg/web/config.js | wc -l) = 0 ]; then
cat << EOF | /usr/bin/sudo /usr/bin/sed -i '/constraints: {/r /dev/stdin' .jitsi-meet-cfg/web/config.js
    constraints: {
        video: {
            height: {
                ideal: 720,
                max: 720,
                min: 180
            },
            width: {
                    ideal: 1280,
                    max: 1280,
                    min: 320
            }
        }
    },

    videoQuality: {
            maxBitratesVideo: {
            low: 200000,
            standard: 500000,
            high: 1500000
        },
    },
EOF
fi

# Limitation of the transmitted video feeds
# https://github.com/jitsi/jitsi-videobridge/blob/master/doc/last-n.md
/usr/bin/sudo /usr/bin/sed -i 's#channelLastN: -1,#channelLastN: 20,#' .jitsi-meet-cfg/web/config.js

# Enable Layer Suspension
# https://jitsi.org/blog/new-off-stage-layer-suppression-feature/
/usr/bin/sudo /usr/bin/sed -i 's#// enableLayerSuspension: false,#enableLayerSuspension: true,#' .jitsi-meet-cfg/web/config.js

# Disable recording
/usr/bin/sudo /usr/bin/sed -i 's#// fileRecordingsEnabled: false,#fileRecordingsEnabled: false,#' .jitsi-meet-cfg/web/config.js

# Disable livestreaming
/usr/bin/sudo /usr/bin/sed -i 's#// liveStreamingEnabled: false,#liveStreamingEnabled: false,#' .jitsi-meet-cfg/web/config.js

