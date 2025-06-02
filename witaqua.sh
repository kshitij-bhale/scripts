#!/bin/bash

# Clean old manifests
rm -rf .repo/local_manifests

# Initialize WitAqua source
repo init -u https://github.com/WitAqua/manifest.git -b 15.2 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Clone local manifest
git clone https://github.com/kshitij-bhale/local_manifests_mido --depth=1 -b witaqua-15 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Use Crave's sync method
/opt/crave/resync.sh
echo "======== Synced Successfully ========"

# Environment setup
source build/envsetup.sh
echo "======== Environment setup done ========"

# Device + GApps variant lunch
lunch lineage_mido-bp1a-userdebug
echo "======== Lunch command done ========"

# Start the build with full CPU usage
mka bacon
