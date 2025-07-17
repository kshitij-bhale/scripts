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

echo "======== Nuking all test modules from art/ ========"

# Remove all art/ test directories
find art -type d -name test | xargs rm -rf

# Patch all Android.bp under art/ to comment out test modules
find art -name Android.bp | while read -r bp; do
  sed -i 's/^\(\s*\)name: *"art_.*_tests"/\1\/\/ &/' "$bp"
  sed -i 's/^\(\s*\)name: *"art_standalone_.*_tests"/\1\/\/ &/' "$bp"
  sed -i 's/^\(\s*\)name: *"lib.*-gtest"/\1\/\/ &/' "$bp"
  sed -i 's/^\(\s*\)name: *".*_gtest_defaults"/\1\/\/ &/' "$bp"
  sed -i 's/^\(\s*\)name: *".*_test_defaults"/\1\/\/ &/' "$bp"
  sed -i 's/^\(\s*\)test_config_template:/\1\/\/ &/' "$bp"
done

# set skip-tests flag
export WITHOUT_TESTS=true

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

lunch miku_rhode-bp2a-userdebug
echo "======== Lunched ========"

make diva
