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

# Don't create /etc/ld.so.cache — systemd will recreated it when booting
LDCONFIGDEPEND = ""

# These are files we don't want to update/overwrite on the target when the OS
# updates:
# mtab — currently mounted filesystems & their options
# machine-id — unique id of the local system. Generated at boot time if it's
#  found to be empty
STATEFUL_FILES = "\
  /etc/mtab \
  /etc/machine-id \
"
# This postfunc runs after the do_copy_bundle_contents task and ensures that
# any files in /etc we don't want to update with the OS are removed from the
# bundle directories
python myhouse_rm_config_files () {
  oscore = d.expand('${DEPLOY_DIR_SWUPD}/image/${OS_VERSION}/os-core')
  for tgt in (d.getVar('STATEFUL_FILES', True) or '').split():
    try:
      os.remove(os.path.join(oscore, tgt))
    except Exception as e:
      bb.note('Failed to delete file: %s due to %s' % (tgt, str(e)))
}
do_swupd_update[prefuncs] += "myhouse_rm_config_files"
