crave run --no-patch -- "rm -rf .repo/local_manifests; \
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs; \
git clone https://github.com/kshitij-bhale/local_manifests --depth 1 -b crdroid11 .repo/local_manifests; \ 
/opt/crave/resync.sh; \
source build/envsetup.sh; \
breakfast hawao userdebug; \ 
mka bacon"
