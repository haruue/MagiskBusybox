#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in post-fs-data mode

# More info in the main Magisk thread
cd $MODDIR/system/xbin

# Merge origin files in /system/xbin
echo "Merging origin /system/xbin..."
for f in /system/xbin/*; do 
    LINK=$(readlink $f)
    if [ "$LINK" == "" -a "$f" != "/system/xbin/busybox" -o "$LINK" != "/system/xbin/busybox" -a "$f" != "/system/xbin/busybox" ]; then
        echo "copying" "$f"
        cp -a "$f" .
    fi
done

# Create symbol links for busybox
echo "Creating symbol-links..."
tar xvf symbol-links.tar
rm symbol-links.tar

