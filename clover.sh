#!/bin/bash

# Clean up
rm -rf .repo/local_manifests
rm -rf packages/apps/Settings
rm -rf device/motorola/devon
rm -rf .repo/projects/art.git
rm -rf vendor/clover
rm -rf prebuilts/clang/host/linux-x86

# Initialize Clover porject source
repo init -u https://github.com/kshitij-bhale/manifest.git -b 16 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

git clone https://github.com/kshitij-bhale/packages_apps_Settings --depth=1 -b 16 packages/apps/Settings
git clone https://github.com/kshitij-bhale/vendor_clover --depth=1 -b 16 vendor/clover

# Clone local manifest
git clone https://github.com/kshitij-bhale/local_manifests --depth=1 -b clover .repo/local_manifests
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

# Lunch
lunch clover_devon-bp2a-eng
echo "======== Lunch command done ========"

# Start the build
mka clover
