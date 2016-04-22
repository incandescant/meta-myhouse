FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# We want busybox utilities to have a higher priority than coreutils
ALTERNATIVE_PRIORITY = "100"

SRC_URI_append = "file://myhouse.cfg"

# We disable syslogd in myhouse.cfg as we utilise systemd's journal for
# logging, therefore drop the syslog package too
SYSTEMD_PACKAGES = ""
PACKAGES_remove = "${PN}-syslog"
RRECOMMENDS_${PN}_remove = "${PN}-syslog"
