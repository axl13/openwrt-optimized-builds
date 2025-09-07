#!/bin/bash

# Clone gwlim's pre-patched OpenWrt source for SFE
git clone https://github.com/gwlim/openwrt.git -b 23.05-sfe openwrt
cd openwrt

# Patches are already included in the source. No manual patching needed.

# Update feeds
./scripts/feeds update -a
./scripts/feeds install -a

# Copy config
cp ../wndr3700-v1-sfe-debug.config .config

# Build firmware
make defconfig
make download -j$(nproc)
make -j$(nproc)
