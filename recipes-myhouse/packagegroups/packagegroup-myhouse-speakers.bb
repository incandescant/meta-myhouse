SUMMARY = "Software for the speakers product"
LICENSE = "MIT"

inherit packagegroup

# We're only just starting development so don't have any custom packages yet,
# nor do we know the final content of the speaker product, but we're fairlty
# certain we want to support zerconf usage.
RDEPENDS_${PN} = "\
  pulseaudio-server \
  pulseaudio-module-zeroconf-discover \
"
