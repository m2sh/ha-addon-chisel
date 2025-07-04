#!/bin/sh
# ==============================================================================
# Home Assistant Add-on: Chisel
#
# Container build of Chisel
# ==============================================================================

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
wget -O /usr/bin/chisel "https://github.com/jpillora/chisel/releases/download/v${chiselRelease}/chisel_${chiselRelease}_linux_${arch}.gz"

# Extract the gzipped binary
gunzip /usr/bin/chisel

# Make the downloaded binary executable
chmod +x /usr/bin/chisel

# Remove legacy cont-init.d services
rm -rf /etc/cont-init.d

# Remove s-6 legacy/deprecated (and not needed) services
rm /package/admin/s6-overlay/etc/s6-rc/sources/base/contents.d/legacy-cont-init
rm /package/admin/s6-overlay/etc/s6-rc/sources/base/contents.d/fix-attrs
rm /package/admin/s6-overlay/etc/s6-rc/sources/top/contents.d/legacy-services 