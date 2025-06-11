#!/bin/bash

# Clean old manifests
rm -rf .repo/local_manifests

# Initialize AxionAOSP source
repo init -u https://github.com/AxionAOSP/android.git -b lineage-22.2 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Clone local manifest
git clone https://github.com/kshitij-bhale/local_manifests --depth 1 -b axion .repo/local_manifests
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

# Generate private signing keys
gk -s
echo "======== Private key generated ========"

# Device + GApps variant lunch
lunch lineage_hawao-bp1a-userdebug
echo "======== Lunch command done ========"

# Start the build with full CPU usage
ax -br
