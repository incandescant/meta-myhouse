SUMMARY = "Core OS image for myHouse and configuration of os-core and bundles"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit core-image swupd-image myhouse-core-qa

# The base image is pretty minimal. We use the core boot packagegroup to start
# and also add connman for easier network setup.
IMAGE_INSTALL = "\
    packagegroup-core-boot\
    avahi-daemon \
    connman \
    connman-client \
"

# swupd bundle definitions
SWUPD_BUNDLES = "developer hub speakers"
# The developer bundle is used to provide additional tools on the device for
# our developers
BUNDLE_CONTENTS[developer] = "\
    packagegroup-core-sdk \
    packagegroup-core-standalone-sdk-target \
    packagegroup-core-tools-debug \
    bash \
    connman-tools \
    coreutils \
"
# Speakers is our first product build on myHouse — the extra packages required
# for the product are defined in the packagegroup-myhouse-speakers recipe
BUNDLE_CONTENTS[speakers] = "\
    packagegroup-myhouse-media \
    packagegroup-myhouse-speakers \
"

# Hub is our product that will act as a personal cloud and command & control for
# all of the other myHouse products
BUNDLE_CONTENTS[hub] = "\
    packagegroup-myhouse-media \
    packagegroup-myhouse-hub \
"

# We also want the option to build an extra image that provides a software load
# for our speakers product without having to flash the core image then manually
# add the speakers bundle.
SWUPD_IMAGES = "hub speakers"
SWUPD_IMAGES[hub] = "hub"
SWUPD_IMAGES[speakers] = "speakers"
