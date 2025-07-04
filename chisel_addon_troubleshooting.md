# Troubleshooting "manifest unknown" Error for Chisel Add-on

## Error Summary

You're encountering the following error when trying to install the Chisel add-on in Home Assistant:

```
Can't install ghcr.io/m2sh/ha-addon-chisel/aarch64:1.9.1: 500 Server Error for http+docker://localhost/v1.48/images/create?tag=1.9.1&fromImage=ghcr.io%2Fm2sh%2Fha-addon-chisel%2Faarch64&platform=linux%2Farm64: Internal Server Error ("manifest unknown")
```

## What This Error Means

A "manifest unknown" error occurs when Docker cannot find the specified image manifest. This typically happens when:

1. **Image doesn't exist**: The specific version (1.9.1) for your architecture (aarch64) doesn't exist in the repository
2. **Repository issues**: The GitHub Container Registry (ghcr.io) repository is inaccessible or has been moved/deleted
3. **Architecture not supported**: The add-on may not be built for ARM64/aarch64 architecture
4. **Network connectivity**: Issues reaching the GitHub Container Registry

## Troubleshooting Steps

### 1. Check Available Versions and Architectures

First, verify what versions and architectures are available:

1. **Visit the GitHub repository**: Go to `https://github.com/m2sh/ha-addon-chisel` to check if the repository exists
2. **Check package registry**: Look at `https://github.com/m2sh/ha-addon-chisel/pkgs/container/ha-addon-chisel` for available images
3. **Verify supported architectures**: Check if ARM64/aarch64 builds are available for version 1.9.1

### 2. Try Different Versions

If version 1.9.1 isn't available for your architecture:

1. **Check latest version**: Try installing the latest available version instead
2. **Use different tag**: Some repositories use different tagging schemes (e.g., `latest`, `stable`)

### 3. Network and Connectivity Checks

Verify your Home Assistant instance can reach the registry:

1. **DNS resolution**: Ensure your system can resolve `ghcr.io`
2. **Firewall/proxy**: Check if any firewall or proxy is blocking access to GitHub Container Registry
3. **Internet connectivity**: Verify your Home Assistant instance has internet access

### 4. Check Home Assistant Logs

Look for additional error details in your Home Assistant logs:

1. Go to **Settings** → **System** → **Logs**
2. Look for entries related to the add-on installation
3. Check Supervisor logs for more detailed error information

### 5. Alternative Installation Methods

If the specific version isn't available, consider:

1. **Manual installation**: Clone the repository and build locally if possible
2. **Alternative add-ons**: Look for similar functionality in other add-ons
3. **Docker container**: Run Chisel as a standalone Docker container instead of a Home Assistant add-on

### 6. Clear Docker Cache

Sometimes clearing the Docker image cache helps:

1. **Restart Home Assistant**: This can clear temporary Docker issues
2. **Supervisor restart**: Restart the Home Assistant Supervisor
3. **Full system reboot**: If other methods don't work

## Common Causes and Solutions

### Architecture Compatibility

Your system is running on **aarch64** (ARM64) architecture. Some add-ons may not provide builds for all architectures:

- **Solution**: Look for ARM64-compatible versions or alternative add-ons
- **Check**: Verify if the add-on developer provides multi-architecture builds

### Repository Changes

The add-on repository might have been:

- **Moved**: Check if the developer has moved to a different repository
- **Archived**: The project might be discontinued
- **Renamed**: The package name might have changed

### Version Availability

Version 1.9.1 might:

- **Not exist**: The version number might be incorrect
- **Be in development**: Pre-release versions might not be publicly available
- **Be architecture-specific**: Only available for certain architectures

## Recommended Actions

1. **Check repository status**: Visit the GitHub repository to verify it's still active
2. **Contact developer**: Reach out to the add-on developer for support
3. **Try latest version**: Install the latest available version instead of 1.9.1
4. **Community forums**: Check Home Assistant community forums for similar issues
5. **Alternative solutions**: Consider using Chisel as a standalone Docker container

## Additional Resources

- **Home Assistant Add-on Store**: Look for officially supported tunnel/proxy add-ons
- **Docker Hub**: Check if Chisel is available as a standard Docker image
- **Community Add-ons**: Explore community-maintained alternatives
- **Home Assistant Documentation**: Review add-on troubleshooting guides

## Prevention

To avoid similar issues in the future:

1. **Check compatibility**: Always verify architecture compatibility before installing
2. **Use stable versions**: Prefer stable releases over development versions
3. **Regular updates**: Keep Home Assistant and Supervisor updated
4. **Monitor repositories**: Follow add-on repositories for updates and changes

---

**Note**: This error is specific to the Docker image manifest not being found. If you continue experiencing issues, consider reaching out to the Home Assistant community or the specific add-on developer for assistance.