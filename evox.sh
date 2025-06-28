#!/bin/bash

# Clean old manifests
rm -rf .repo/local_manifests

# Initialize EvoX source
repo init -u https://github.com/Evolution-X/manifest -b bka --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Clone local manifest
git clone https://github.com/kshitij-bhale/local_manifests --depth=1 -b evo-16 .repo/local_manifests
rm -rf hardware/qcom/audio
git clone https://github.com/ZetLink/android_hardware_qcom_audio --depth=1 -b lineage-22.2-caf-sm8250 hardware/qcom/audio
echo "============================"
echo "Local manifest clone success"
echo "============================"

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
m evolution
