#!/bin/bash

# Clone local manifest 
repo init -u https://github.com/kshitij-bhale/android_device_generic_common --depth 1 -b lineage-22.2 device/generic/common

# ROM source repo
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Re-sync
/opt/crave/resync.sh
echo "======== Synced Successfully ========"

# Build ROM
export TARGET_RELEASE=15.0
source build/envsetup.sh
breakfast sdk_phone_x86_64 userdebug
mka emu_img_zip
