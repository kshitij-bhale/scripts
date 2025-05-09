#!/bin/bash

rm -rf .repo/local_manifests/

# ROM repo
repo init -u https://github.com/hentaiOS/platform_manifest -b Vallhound --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local repository
git clone https://github.com/kshitij-bhale/local_manifests --depth 1 -b helluvaos .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Re-sync
/opt/crave/resync.sh
echo "======== Synced Successfully ========"
source build/envsetup.sh
echo "======== Environment setup done ========"

#Build ROM
lunch hentai_hawao-bp1a-userdebug
echo "======== Lunched ========"
m bacon
