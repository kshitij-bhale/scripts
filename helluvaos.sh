#!/bin/bash

rm -rf .repo/local_manifests/
rm -rf hardware/qcom-caf/common
rm -rf device/qcom/sepolicy_vndr

# ROM repo
repo init -u https://github.com/hentaiOS/platform_manifest -b Vallhound --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local repository
git clone https://github.com/kshitij-bhale/local_manifests --depth 1 -b helluvaos .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Add qcom-caf
git clone https://github.com/kshitij-bhale/android_hardware_qcom-caf_common hardware/qcom-caf/common

#Added sepolicy
git clone --depth=1 https://github.com/hentaiOS/platform_device_qcom_sepolicy_vndr

# Re-sync
/opt/crave/resync.sh
echo "======== Synced Successfully ========"
source build/envsetup.sh
echo "======== Environment setup done ========"

#Build ROM
lunch hentai_hawao-bp1a-userdebug
echo "======== Lunched ========"
m bacon
