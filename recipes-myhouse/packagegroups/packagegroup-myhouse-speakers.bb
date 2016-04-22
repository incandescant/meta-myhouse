SUMMARY = "Software for the speakers product"
LICENSE = "MIT"

inherit packagegroup

# We're only just starting development so don't have any custom packages yet,
# nor do we know the final content of the speaker product, but we're fairly
# certain we want to use pulseaudio and be able to act as a UPnP renderer for
# audio.
RDEPENDS_${PN} = "\
    gstreamer1.0-meta-audio \
"
