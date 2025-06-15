#!/bin/bash

# ROM source repo
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Re-sync
/opt/crave/resync.sh
echo "======== Synced Successfully ========"

# Building ROM
source build/envsetup.sh
lunch sdk_phone64_arm64-userdebug
mka emu_img_zip
