#!/bin/bash

rm -rf .repo/local_manifests

# ROM repo
repo init -u https://github.com/ProjectPixelage/android_manifest.git -b 15 --git-lfs
git clone https://github.com/kshitij-bhale/local_manifests --depth 1 -b pixelage-15 .repo/local_manifests
echo "=================="
echo "Repo init success"
echo "=================="

# Re-sync
/opt/crave/resync.sh
echo "======== Synced Successfully ========"
source build/envsetup.sh
echo "======== Environment setup done ========"

# Build ROM
lunch pixelage_hawao-bp1a-userdebug
echo "======== Lunched ========"
mka bacon
