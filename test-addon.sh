#!/bin/bash

# Test script for Chisel Home Assistant Add-on
# This script validates the addon structure and configuration

set -e

echo "Testing Chisel Home Assistant Add-on..."

# Check if required files exist
echo "Checking required files..."

required_files=(
    "chisel/config.yaml"
    "chisel/Dockerfile"
    "chisel/build.yaml"
    "chisel/rootfs/build.sh"
    "chisel/rootfs/etc/s6-overlay/s6-rc.d/chisel/run"
    "chisel/rootfs/etc/s6-overlay/s6-rc.d/chisel/type"
    "chisel/rootfs/etc/s6-overlay/s6-rc.d/chisel/finish"
    "chisel/rootfs/etc/s6-overlay/s6-rc.d/init-chisel-config/type"
    "chisel/rootfs/etc/s6-overlay/s6-rc.d/init-chisel-config/up"
    "chisel/rootfs/etc/s6-overlay/scripts/chisel-config.sh"
    "chisel/rootfs/etc/s6-overlay/s6-rc.d/user/contents.d/chisel"
    "README.md"
    "LICENSE.md"
)

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "ERROR: Required file $file is missing"
        exit 1
    else
        echo "✓ $file exists"
    fi
done

# Validate YAML files
echo "Validating YAML files..."

if command -v yamllint >/dev/null 2>&1; then
    yamllint chisel/config.yaml
    yamllint chisel/build.yaml
    echo "✓ YAML files are valid"
else
    echo "⚠ yamllint not found, skipping YAML validation"
fi

# Check if build script is executable
if [ ! -x "chisel/rootfs/build.sh" ]; then
    echo "ERROR: build.sh is not executable"
    exit 1
else
    echo "✓ build.sh is executable"
fi

# Check if run script is executable
if [ ! -x "chisel/rootfs/etc/s6-overlay/s6-rc.d/chisel/run" ]; then
    echo "ERROR: chisel run script is not executable"
    exit 1
else
    echo "✓ chisel run script is executable"
fi

# Check if config script is executable
if [ ! -x "chisel/rootfs/etc/s6-overlay/scripts/chisel-config.sh" ]; then
    echo "ERROR: chisel-config.sh is not executable"
    exit 1
else
    echo "✓ chisel-config.sh is executable"
fi

# Validate config.yaml structure
echo "Validating config.yaml structure..."

# Check if mode is defined
if ! grep -q "mode:" chisel/config.yaml; then
    echo "ERROR: mode not defined in config.yaml"
    exit 1
fi

# Check if required ports are defined
if ! grep -q "8080/tcp" chisel/config.yaml; then
    echo "ERROR: Port 8080 not defined in config.yaml"
    exit 1
fi

echo "✓ config.yaml structure is valid"

# Check Dockerfile
echo "Validating Dockerfile..."

if ! grep -q "ARG BUILD_FROM" chisel/Dockerfile; then
    echo "ERROR: BUILD_FROM not defined in Dockerfile"
    exit 1
fi

if ! grep -q "COPY rootfs" chisel/Dockerfile; then
    echo "ERROR: rootfs copy not found in Dockerfile"
    exit 1
fi

echo "✓ Dockerfile is valid"

echo ""
echo "🎉 All tests passed! The Chisel addon structure is valid."
echo ""
echo "Next steps:"
echo "1. Add proper icon.png and logo.png files"
echo "2. Test the addon in a Home Assistant environment"
echo "3. Create a release" 