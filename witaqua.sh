#!/bin/bash

# Clean old manifests
rm -rf .repo/local_manifests
rm -rf prebuilts/clang/host/linux-x86

# Initialize WitAqua source
repo init -u https://github.com/WitAqua/manifest.git -b 16.0 --git-lfs
echo "=================="
echo "Repo init success"
#echo "=================="

# Clone local manifest
git clone https://github.com/kshitij-bhale/local_manifests --depth 1 -b witaqua-15 .repo/local_manifests
rm -rf hardware/qcom/audio
git clone https://github.com/ZetLink/android_hardware_qcom_audio --depth 1 -b lineage-22.1-caf-sm8250 hardware/qcom/audio
echo "============================"
echo "Local manifest clone success"
echo "============================"

# # Clone MOTOCAM
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotCamera4-bengal.git -b android-15 vendor/motorola/MotCamera4-bengal
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotCamera-common.git -b android-15 vendor/motorola/MotCamera-common
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotoPhotoEditor.git -b android-15 vendor/motorola/MotoPhotoEditor
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotCamera3AI-bengal.git -b android-15 vendor/motorola/MotCamera3AI-bengal
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotCameraAI-common.git -b android-15 vendor/motorola/MotCameraAI-common
# git clone https://github.com/Deivid-21s-Sources/proprietary_vendor_motorola_MotoSignatureApp.git -b android-15 vendor/motorola/MotoSignatureApp
# git clone https://gitlab.com/Deivid21/proprietary_vendor_motorola_MotorolaSettingsProvider.git -b android-15 vendor/motorola/MotorolaSettingsProvider

# Use Crave's sync method
/opt/crave/resync.sh
echo "======== Synced Successfully ========"

# KernelSU Next setup
cd kernel/motorola/sm6225
echo "======== Inside kernel/motorola/sm6225 ========"
curl -LSs "https://raw.githubusercontent.com/rifsxd/KernelSU-Next/next/kernel/setup.sh" | bash -
echo "======== Added KSU successfully ========"
cd ../../..
echo "======== Returned to root directory ========"

# Environment setup
source build/envsetup.sh
echo "======== Environment setup done ========"

# lunch
lunch lineage_rhode-bp2a-userdebug
echo "======== Lunch command done ========"

# Start the build
mka bacon
