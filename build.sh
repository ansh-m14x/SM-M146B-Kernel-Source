#!/bin/bash

# Configuration from screenshot
export DTC_FLAGS="-@"
export PLATFORM_VERSION=15
export ANDROID_MAJOR_VERSION=v
export LLVM=1
export DEPMOD=depmod
export ARCH=arm64
export TARGET_SOC=s5e8535

# Toolchain Path Setup
# We point to the local 'toolchain' folder created by the GitHub Action
TOOLCHAIN_ROOT="$(pwd)/toolchain"
export PATH="$TOOLCHAIN_ROOT/bin:$PATH"

# Build Commands
echo "================================================="
echo "DEVICE: M14 5G (m14x)"
echo "CONFIG: s5e8535-m14xnsxx_defconfig"
echo "================================================="

# Clean previous builds
rm -rf out

# Generate the config
make O=out s5e8535-m14xnsxx_defconfig

# Start the compilation
echo "Starting build with $(nproc --all) cores..."
make -j$(nproc --all) O=out \
    CROSS_COMPILE=aarch64-linux-gnu- \
    CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
    LLVM=1 \
    LLVM_IAS=1

echo "================================================="
echo "Build Process Completed"
echo "================================================="
