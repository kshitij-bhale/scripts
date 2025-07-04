#!/bin/bash

# Clean old manifests
rm -rf .repo/local_manifests
rm -rf kernel/motorola/sm6225

# Initialize WitAqua source
repo init -u https://github.com/WitAqua/manifest.git -b 15.2 --git-lfs
echo "=================="
echo "Repo init success"
#echo "=================="

# Clone local manifest
git clone https://github.com/kshitij-bhale/local_manifests --depth 1 -b witaqua-15 .repo/local_manifests
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
lunch lineage_hawao-bp1a-userdebug
echo "======== Lunch command done ========"

# Start the build
mka bacon
