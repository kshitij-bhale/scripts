#!/bin/bash

# Clean old manifests
# rm -rf .repo/local_manifests
# rm -rf device/motorola/sm6225-common
# rm -rf vendor/motorola/devon
# rm -rf vendor/motorola/rhode
# rm -rf vendor/motorola/hawao
# rm -rf vendor/motorola/sm6225-common
# rm -rf hardware/motorola
# rm -rf prebuilts/clang/host/linux-x86

# # Initialize AxionAOSP source
repo init -u https://github.com/The-Clover-Project/manifest.git -b 16-qpr1 --git-lfs --depth=1
echo "=================="
echo "Repo init success"
echo "=================="

# Clone local manifest
# git clone https://github.com/kshitij-bhale/local_manifests --depth 1 -b clover .repo/local_manifests
# echo "============================"
# echo "Local manifest clone success"
# echo "============================"

# Use Crave's sync method
/opt/crave/resync.sh
echo "======== Synced Successfully ========"

# KernelSU Next setup
# cd kernel/motorola/sm6225
# echo "======== Inside kernel/motorola/sm6225 ========"
# curl -LSs "https://raw.githubusercontent.com/rifsxd/KernelSU-Next/next/kernel/setup.sh" | bash -
# echo "======== Added KSU successfully ========"
# cd ../../..
# echo "======== Returned to root directory ========"

# Environment setup
source build/envsetup.sh
echo "======== Environment setup done ========"

# Device + GApps variant lunch
lunch clover_devon-bp3a-userdebug
echo "======== Lunch command done ========"

# Start the build with full CPU usage
mka clover
