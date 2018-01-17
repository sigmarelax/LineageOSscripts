#!/usr/bin/env bash

# Suggested build environment: Ubuntu 16.04, >8GB ram, >100 GB SSD (GCP's "n1-standard-4" works well)

# These two values required to init the LineageOS repo
export NAME="sigmarelax"
export EMAIL="sigmarelax@gmail.com"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install bc bison build-essential curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev libesd0-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc yasm zip zlib1g-dev openjdk-8-jdk -y

wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip && unzip platform-tools-latest-linux.zip -d ~

mkdir bin
mkdir -p android/lineage
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo -e "\nif [ -d \"\$HOME/platform-tools\" ] ; then\n    PATH=\"\$HOME/platform-tools:\$PATH\"\nfi\n\nif [ -d \"\$HOME/bin\" ] ; then\n    PATH=\"\$HOME/bin:\$PATH\"\nfi" >> ~/.profile
source ~/.profile

cd ~/android/lineage
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global color.ui false
repo init -u https://github.com/LineageOS/android.git -b cm-14.1 --depth=1
repo sync

mkdir -p .repo/local_manifests
# This is the only device-specific command of this script:
wget https://raw.githubusercontent.com/sigmarelax/LineageOSscripts/master/RIOandroid_manifest.xml -O .repo/local_manifests/android_manifest.xml
repo sync

export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"
source build/envsetup.sh
breakfast rio
brunch rio

# The flashable .zip will be at ~/android/lineage/out/target/product/rio/lineage-14.1-2018XXXX-UNOFFICIAL-rio.zip
