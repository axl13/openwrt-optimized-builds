#!/bin/bash

# Clone OpenWrt 23.05.3 source code
git clone https://github.com/openwrt/openwrt.git -b v23.05.3 openwrt
cd openwrt

# Apply SFE patches from gwlim fork
wget -O 0001-sfe-flowoffload.patch "https://raw.githubusercontent.com/gwlim/openwrt-sfe-flowoffload-ath79/master/patches/0001-sfe-flowoffload.patch"
wget -O 0002-sfe-shortcut-for-prev-and-next-headers.patch "https://raw.githubusercontent.com/gwlim/openwrt-sfe-flowoffload-ath79/master/patches/0002-sfe-shortcut-for-prev-and-next-headers.patch"
git apply 0001-sfe-flowoffload.patch
git apply 0002-sfe-shortcut-for-prev-and-next-headers.patch

# Update feeds
./scripts/feeds update -a
./scripts/feeds install -a

# Copy config
cp ../wndr3700-v1-sfe-debug.config .config

# Build firmware
make defconfig
make download -j$(nproc)
make -j$(nproc)
