SUMMARY = "Software for the hub product"
LICENSE = "MIT"

inherit packagegroup

# We're only just starting development so don't have any custom packages yet,
# nor do we know the final content of the hub product, but we're fairly
# certain we want to support exporting media to UPnP renderers
RDEPENDS_${PN} = "\
    gstreamer1.0-meta-audio \
    gstreamer1.0-meta-video \
"
