inherit core-image swupd-image

# The base image is pretty minimal. We use the core boot packagegroup to start
# and also add connman for easier network setup.
IMAGE_INSTALL = "packagegroup-core-boot connman"

# swupd bundle definitions
SWUPD_BUNDLES = "developer speakers"
# The developer bundle is used to provide additional tools on the device for
# our developers
BUNDLE_CONTENTS[developer] = "\
  packagegroup-core-sdk \
  packagegroup-core-standalone-sdk-target \
  packagegroup-core-tools-debug \
  connman-tools \
  connman-client \
  coreutils \
  bash \
"
# Speakers is our first product build on myHouse — the extra packages required
# for the product are defined in the packagegroup-myhouse-speakers recipe
BUNDLE_CONTENTS[speakers] = "\
  packagegroup-myhouse-speakers \
"

# We also want the option to build an extra image that provides a software load
# for our speakers product without having to flash the core image then manually
# add the speakers bundle.
SWUPD_IMAGES = "speakers"
SWUPD_IMAGES[speakers] = "speakers"
