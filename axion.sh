#!/bin/bash

rm -rf .repo/local_manifests

# ROM source repo
repo init -u https://github.com/AxionAOSP/android.git -b lineage-22.2 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifest
git clone https://github.com/kshitij-bhale/local_manifests --depth 1 -b axion .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Re-sync
/opt/crave/resync.sh
echo "======== Synced Successfully ========"

# Add KSU next
cd kernel/motorola/sm6225
echo "======== Inside kernel/motorola/sm6225 ========"
curl -LSs "https://raw.githubusercontent.com/rifsxd/KernelSU-Next/next/kernel/setup.sh" | bash -
echo "======== Added KSU successfully ========"
cd ../../..
echo "======== changed directory ========"

# Building 
source build/envsetup.sh
echo "======== Environment setup done ========"
gk -s
echo "======== Private key generated ========"
axion hawao gms mini
echo "======== Lunched ========"
ax -br
