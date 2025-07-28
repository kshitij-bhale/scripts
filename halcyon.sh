#!/bin/bash

rm -rf .repo/local_manifests
rm -rf prebuilts/clang/host/linux-x86

# ROM source repo
repo init -u https://github.com/blumengarten/manifest -b 16.0 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifest
git clone https://github.com/kshitij-bhale/local_manifests --depth 1 -b halcyon-16 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Re-sync
/opt/crave/resync.sh
echo "======== Synced Successfully ========"

# MotoCam
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotCamera4-bengal.git -b android-15 vendor/motorola/MotCamera4-bengal
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotCamera-common.git -b android-15 vendor/motorola/MotCamera-common
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotoPhotoEditor.git -b android-15 vendor/motorola/MotoPhotoEditor
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotCamera3AI-bengal.git -b android-15 vendor/motorola/MotCamera3AI-bengal
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotCameraAI-common.git -b android-15 vendor/motorola/MotCameraAI-common
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotoSignatureApp.git -b android-15 vendor/motorola/MotoSignatureApp
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotorolaSettingsProvider.git -b android-15 vendor/motorola/MotorolaSettingsProvider

# Add KSU next
cd kernel/motorola/sm6225
echo "======== Inside kernel/motorola/sm6225 ========"
curl -LSs "https://raw.githubusercontent.com/rifsxd/KernelSU-Next/next/kernel/setup.sh" | bash -
echo "======== Added KSU successfully ========"
cd ../../..
echo "======== changed directory ========"

# Building ROM
source build/envsetup.sh
echo "======== Environment setup done ========"
lunch halcyon_rhode-bp2a-userdebug
echo "======== Lunched ========"
mka carthage
