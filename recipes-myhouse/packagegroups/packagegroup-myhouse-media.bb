SUMMARY = "Software shared by all products that provide multimedia functions"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_${PN} = "\
    gstreamer1.0 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-good-pulse \
    libasound-module-conf-pulse \
    libasound-module-ctl-pulse \
    libasound-module-pcm-pulse \
    pulseaudio \
    pulseaudio-server \
"
