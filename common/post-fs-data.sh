#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}
MIRROR_DIR="/dev/magisk/mirror"

# This script will be executed in post-fs-data mode

# More info in the main Magisk thread
cd $MODDIR/system/xbin

# Merge origin files in /system/xbin
cp -a $MIRROR_DIR/system/xbin/* .

# Create symbol links for busybox
tar xvf symbol-links.tar
rm symbol-links.tar

