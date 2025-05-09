#!/bin/bash

rm -rf .repo/local_manifests; \

# ROM source repo
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs; \

# Local manifest
git clone https://github.com/kshitij-bhale/local_manifests --depth 1 -b crdroid11 .repo/local_manifests; \ 

# Re-sync
/opt/crave/resync.sh; \

# Building ROM
source build/envsetup.sh; \
breakfast hawao userdebug; \ 
mka bacon"
