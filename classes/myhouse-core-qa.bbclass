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
    bundles = (d.getVar('SWUPD_BUNDLES', True) or '').split()
    bundles.append('os-core')
    bundledir = d.expand('${DEPLOY_DIR_SWUPD}/image/${OS_VERSION}/')
    for bundle in bundles:
        bdir = bundledir + bundle
        for tgt in (d.getVar('STATEFUL_FILES', True) or '').split():
            fpath = bdir + tgt
            bb.debug(3, "Trying to remove %s (%s), listed in STATEFUL_FILES, from swupd bundle directory for '%s'." % (tgt, fpath, bundle))
            try:
                os.remove(fpath)
            except Exception as e:
                bb.debug(1, "Couldn't delete %s (%s) in STATEFUL_FILES from swupd bundle directory for '%s':\n%s" % (tgt, fpath, bundle, str(e)))
}
do_swupd_update[prefuncs] += "myhouse_rm_config_files"
