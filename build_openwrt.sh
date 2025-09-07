#!/bin/bash

# Clone OpenWrt 23.05.3 source code
git clone https://github.com/openwrt/openwrt.git -b v23.05.3 openwrt
cd openwrt

# Apply SFE patches
wget -O sfe.patch "https://git.codelinaro.org/clo/qsdk/oss/system/openwrt-patches-23.05/-/raw/NHSS.QSDK.12.4.5.r3/0052-netsupport.mk-fix-kmod-nss-sfe-configuration-issues.patch"
git apply sfe.patch

# Update feeds
./scripts/feeds update -a
./scripts/feeds install -a

# Copy config
cp ../wndr3700-v1-sfe-debug.config .config

# Build firmware
make defconfig
make download -j$(nproc)
make -j$(nproc)
