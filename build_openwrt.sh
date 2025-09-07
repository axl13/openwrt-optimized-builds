#!/bin/bash

# Clone OpenWrt 23.05.3 source code
git clone https://github.com/openwrt/openwrt.git -b v23.05.3 openwrt
cd openwrt

# SFE patches are handled by a custom feed. No manual patching needed.

# Update feeds
./scripts/feeds update -a
./scripts/feeds install -a

# Copy config
cp ../wndr3700-v1-sfe-debug.config .config

# Build firmware
make defconfig
make download -j$(nproc)
make -j$(nproc)
