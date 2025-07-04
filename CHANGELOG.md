# Changelog

All notable changes to the Chisel Home Assistant Add-on will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial development version

## [0.0.1] - 2025-01-04

### Added
- Initial release of the Chisel Home Assistant Add-on
- Support for multiple architectures (aarch64, amd64, armv7)
- Server mode configuration
- Client mode configuration
- Comprehensive configuration options for both modes
- S6-overlay service management
- GitHub Actions CI/CD pipeline
- Multi-architecture Docker builds
- Local build support
- Comprehensive documentation

### Features
- **Server Mode**: Run Chisel as a server for accepting client connections
- **Client Mode**: Connect to remote Chisel servers
- **Secure Tunneling**: Create secure TCP/UDP tunnels over HTTP
- **SSH Transport**: All traffic is transported via SSH
- **Flexible Configuration**: Extensive configuration options for both modes
- **Logging**: Configurable log levels and verbose output
- **Authentication**: Support for key-based and file-based authentication
- **TLS Support**: TLS configuration options for secure connections
- **Proxy Support**: HTTP proxy configuration
- **Keep-alive**: Configurable keep-alive settings
- **Retry Logic**: Automatic retry with configurable intervals

### Technical Details
- Based on Home Assistant Add-on Base Image 18.0.2
- Uses Chisel v1.10.1
- S6-overlay for process management
- Multi-stage Docker builds
- GitHub Container Registry integration 