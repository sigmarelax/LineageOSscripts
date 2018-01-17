#!/bin/bash

# This script pulls all necessary changes to enable Substratum themes in a LineageOS 14.1 build
# Uses one sigmarelax repo to avert conflicts, all cherry-picks work fine (as of Dec 11, 2017)

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

if [[ ! -f .repo/local_manifests/substratum.xml ]]; then
    mkdir -p .repo/local_manifests
    curl --silent --output .repo/local_manifests/substratum.xml \
    https://raw.githubusercontent.com/LineageOMS/merge_script/master/substratum.xml
fi

repo sync --force-sync packages/services/ThemeInterfacer
sleep 5

cd frameworks/base
git fetch https://github.com/LineageOMS/android_frameworks_base cm-14.1
git cherry-pick 47cd0c05551b159ec5a4c3a07d95b4ec21ae1380^..99391bff32cf4fbeb8c7db031bc2227ea52cb6db
cd ../..
sleep 5

cd frameworks/native
git fetch https://github.com/LineageOMS/android_frameworks_native cm-14.1
git cherry-pick 0b81a7d0f6bcfaffe9d344ed0dbeab349fcd730f
cd ../..
sleep 5

cd packages/apps/Contacts
git fetch https://github.com/LineageOMS/android_packages_apps_Contacts cm-14.1
git cherry-pick 185a2975f1e94f8cd6aee28dab0f3fe32e9b4e00
cd ../../..
sleep 5

cd packages/apps/ContactsCommon
git fetch https://github.com/LineageOMS/android_packages_apps_ContactsCommon cm-14.1
git cherry-pick 95845462c1463b7b80484b3d9e50c8874c2b5b18^..951aab3d1d194ab610fbcfaec383cdd6570d84a9
cd ../../..
sleep 5

cd packages/apps/Dialer
git fetch https://github.com/LineageOMS/android_packages_apps_Dialer cm-14.1
git cherry-pick 153e42f7a5e354c722ac622c537fdfb2ad954968^..b9de4c28900f3a600d568d772cbf71bbf3c49c6c
cd ../../..
sleep 5

cd packages/apps/ExactCalculator
git fetch https://github.com/LineageOMS/android_packages_apps_ExactCalculator cm-14.1
git cherry-pick 400650eb37009a483214bda81fdf16663fa1fb24^..97c411e4305a5b3e99d2aaa6baf82b86ebe8a1e8
cd ../../..
sleep 5

cd packages/apps/PackageInstaller
git fetch https://github.com/LineageOMS/android_packages_apps_PackageInstaller cm-14.1
git cherry-pick a22759b21f57bdcb164f6fd9b6f9928bad31820d
cd ../../..
sleep 5

cd packages/apps/PhoneCommon
git fetch https://github.com/LineageOMS/android_packages_apps_PhoneCommon cm-14.1
git cherry-pick d970d893e945b36e01650b2051a2a2d57662b2d5
cd ../../..
sleep 5

cd packages/apps/Settings
git fetch https://github.com/sigmarelax/android_packages_apps_Settings cm-14.1
git cherry-pick a3a4d3586d9a5198017f70bc0e1e74eba66d92bf^..b264ede4e7f059d76c0692816ef4c36df7d33675
cd ../../..
sleep 5

cd system/sepolicy
git fetch https://github.com/LineageOMS/android_system_sepolicy cm-14.1
git cherry-pick 5c349415cebcb6ff0563325aab3e1050e993ec3f^..3eb208437d20fc016a9d0c17cc134ea76d06ab5a
cd ../..
sleep 5

cd vendor/cm
git fetch https://github.com/LineageOMS/android_vendor_cm cm-14.1
git cherry-pick 218eed7ae28e1185bf922af710f2b944b6241bc4
git cherry-pick 56a5353e83eb13054a696653a3c978bdfb6c4c04
cd ../..
sleep 3

echo "Pulled all changes. Proceeding to build..."
sleep 5

export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"
source build/envsetup.sh
breakfast rio
brunch rio
