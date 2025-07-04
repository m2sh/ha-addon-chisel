#!/bin/sh
# ==============================================================================
# Home Assistant Add-on: Chisel
#
# Container build of Chisel
# ==============================================================================

set -e

# Machine architecture as first parameter
arch=$1

# Chisel release as second parameter
chiselRelease=$2

# Adapt the architecture to the chisel specific names if needed
# see HA Archs: https://developers.home-assistant.io/docs/add-ons/configuration/#:~:text=the%20add%2Don.-,arch,-list
# see Chisel Archs: https://github.com/jpillora/chisel/releases
case $arch in
    "aarch64")
        arch="arm64"
    ;;

    "armv7")
        arch="armv7"
    ;;
esac

# Download the chisel binary
echo "Downloading Chisel v${chiselRelease} for ${arch}..."
wget -O /tmp/chisel.gz "https://github.com/jpillora/chisel/releases/download/v${chiselRelease}/chisel_${chiselRelease}_linux_${arch}.gz"

# Extract the gzipped binary
echo "Extracting Chisel binary..."
gunzip /tmp/chisel.gz

# Move the extracted binary to the correct location
mv /tmp/chisel /usr/bin/chisel

# Make the downloaded binary executable
chmod +x /usr/bin/chisel

# Verify the binary works
echo "Verifying Chisel binary..."
/usr/bin/chisel --version

# Remove legacy cont-init.d services (if they exist)
if [ -d "/etc/cont-init.d" ]; then
    rm -rf /etc/cont-init.d
fi

# Remove s-6 legacy/deprecated (and not needed) services (if they exist)
if [ -f "/package/admin/s6-overlay/etc/s6-rc/sources/base/contents.d/legacy-cont-init" ]; then
    rm /package/admin/s6-overlay/etc/s6-rc/sources/base/contents.d/legacy-cont-init
fi

if [ -f "/package/admin/s6-overlay/etc/s6-rc/sources/base/contents.d/fix-attrs" ]; then
    rm /package/admin/s6-overlay/etc/s6-rc/sources/base/contents.d/fix-attrs
fi

if [ -f "/package/admin/s6-overlay/etc/s6-rc/sources/top/contents.d/legacy-services" ]; then
    rm /package/admin/s6-overlay/etc/s6-rc/sources/top/contents.d/legacy-services
fi

echo "Chisel installation completed successfully!" 