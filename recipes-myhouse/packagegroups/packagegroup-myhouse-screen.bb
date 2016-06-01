SUMMARY = "Software for products which will render visual content"
LICENSE = "MIT"

inherit packagegroup

RDEPENDS_${PN} = "\
    gstreamer1.0-meta-video \
"
