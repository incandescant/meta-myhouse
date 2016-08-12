SUMMARY = "Core OS image for myHouse and configuration of os-core and bundles"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit core-image swupd-image

# The base image is pretty minimal. We use the core boot packagegroup to start
# and also add connman for easier network setup.
IMAGE_INSTALL = "\
    packagegroup-core-boot\
    avahi-daemon \
    connman \
"

# swupd bundle definitions
SWUPD_BUNDLES = "developer hub renderer test"
SWUPD_EMPTY_BUNDLES = "speakers"

# A bundle of utilities useful for testing images
BUNDLE_CONTENTS[test] = "\
    bash \
    connman-client \
    connman-tools \
    coreutils \
"
# Include ptest packages when available
BUNDLE_FEATURES[test] = "\
    ptest-pkgs \
"

# The developer bundle is used to provide additional tools on the device for
# our developers
BUNDLE_CONTENTS[developer] = "\
    packagegroup-core-sdk \
    packagegroup-core-standalone-sdk-target \
    packagegroup-core-tools-debug \
"
# We also want to include headers and debuginfo in the developer bundle
BUNDLE_FEATURES[developer] = "\
    dev-pkgs \
    dbg-pkgs \
"

# Speakers is our first product build on myHouse — the extra packages required
# for the product are defined in the packagegroup-myhouse-speakers recipe
BUNDLE_CONTENTS[renderer] = "\
    packagegroup-myhouse-media \
    packagegroup-myhouse-speakers \
    packagegroup-myhouse-screen \
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
SWUPD_IMAGES = "hub renderer"
SWUPD_IMAGES[hub] = "hub"
SWUPD_IMAGES[renderer] = "renderer"
