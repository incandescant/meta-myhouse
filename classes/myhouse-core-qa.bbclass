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
