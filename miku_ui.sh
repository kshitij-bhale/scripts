#!/bin/bash

rm -rf .repo/local_manifests
# rm -rf prebuilts/clang/host/linux-x86
echo "==========Clean up done=========="

# ROM source repo
repo init -u https://github.com/Miku-UI/manifesto -b Blooming --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifest
git clone https://github.com/kshitij-bhale/local_manifests --depth=1 -b miku_ui .repo/local_manifests
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

# Nuke all test folders inside art/ to fix build errors
find art -type d -name test | xargs rm -rf
echo "======== Nuked ALL art/*/test directories ========"

lunch miku_rhode-bp2a-userdebug
echo "======== Lunched ========"

# Set flag to skip tests (for extra safety)
export WITHOUT_TESTS=true
echo "======== WITHOUT_TESTS flag set ========"

make diva
