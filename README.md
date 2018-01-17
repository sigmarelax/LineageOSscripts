# LineageOSscripts

Some scripts for building LineageOS for Huawei G8 / GX8

These need to be run with root privileges, so read the scripts before running them

Suggested build environment: Ubuntu 16.04, >8GB ram, 100 GB SSD (Google Cloud's "n1-standard-4" works well)

## LineageOS build
Run the following commands
```
wget https://raw.githubusercontent.com/sigmarelax/LineageOSscripts/master/LineageBuild.sh
chmod +x LineageBuild.sh && ./LineageBuild.sh
```

## LineageOS with Substratum theme support
To build LineageOS with built-in support of Subtratum themes, run Substratum.sh after setting up the LineageOS build environment (which is done throughout the script above)
```
wget https://raw.githubusercontent.com/sigmarelax/LineageOSscripts/master/Substratum.sh
chmod +x Substratum.sh && ./Substratum.sh
```
