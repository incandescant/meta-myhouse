myHouse
=======

A theoretical OS for devices in a home to demonstrate the use of the
[meta-swupd](http://git.yoctoproject.org/cgit/cgit.cgi/meta-swupd) layer.

The proposed scenario is developing a custom Linux-based OS with OpenEmbedded
for a range of in-home devices where a shared core OS is used across multiple
products and product-specific functionality is provided via bundles.

To better support the initial software load onto devices in a factory-like
setting some product specific images, which consist of the os-core bundle and
additional bundles, will also be generated.

This layer provides the following bundles:
* os-core (as required by all swupd based OS)
* hub — the central command and control gateway for all myHouse products in a
      home
* speakers — a UPnP renderer for audio
* developer — for developers to easily add tools for on-device debugging

The base os-core bundle, and default image, are defined in the
myhouse-image-core recipe.

To support the initial product base load additional images are constructed
both of which contain the core OS (*os-core*) and one of the product bundles
(*hub* or *speakers*).

Dependencies
============

This layer depends on:

  URI: git://git.openembedded.org/bitbake
  branch: master

  URI: git://git.openembedded.org/openembedded-core
  layers: meta
  branch: master

  URI: git://git.yoctoproject.org/meta-swupd
  layers: meta-swupd
  branch: master
