#!/bin/bash

rm -rf .repo/local_manifests
rm -rf device/motorola/hawao
rm -rf device/motorola/devon
rm -rf device/motorola/rhode
rm -rf device/motorola/sm6225-common

# ROM source repo
repo init -u https://github.com/Miku-UI/manifesto -b Vampire_v3 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifest
git clone https://github.com/kshitij-bhale/local_manifests --depth 1 -b miku_ui .repo/local_manifests
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

# Building ROM
source build/envsetup.sh
echo "======== Environment setup done ========"
lunch miku_hawao-bp1a-userdebug
echo "======== Lunched ========"
make diva
