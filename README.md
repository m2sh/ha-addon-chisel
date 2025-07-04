# Chisel Home Assistant Add-on

[![GitHub Release][releases-shield]][releases]
![Project Stage][project-stage-shield]
[![License][license-shield]](LICENSE.md)

_Chisel is a fast TCP/UDP tunnel, transported over HTTP, secured via SSH. This add-on provides a secure way to tunnel your Home Assistant instance through firewalls and NAT._

## About

Chisel is a fast TCP/UDP tunnel, transported over HTTP, secured via SSH. Single executable including both client and server. Written in Go (golang). Chisel is mainly useful for passing through firewalls, though it can also be used to provide a secure endpoint into your network.

This add-on allows you to run Chisel in either server or client mode, providing secure tunneling capabilities for your Home Assistant instance.

## Features

- **Dual Mode Support**: Run as either a server or client
- **Secure Tunneling**: SSH-based encryption for all connections
- **Firewall Traversal**: Pass through firewalls and NAT without opening ports
- **SOCKS5 Support**: Optional SOCKS5 proxy functionality
- **Reverse Tunneling**: Support for reverse port forwarding
- **Authentication**: User authentication with config files
- **TLS Support**: Full TLS/SSL support for secure connections
- **Auto-reconnection**: Client automatically reconnects with exponential backoff
- **Multiple Architectures**: Supports aarch64, amd64, and armv7

## Installation

The installation of this add-on is pretty straightforward and not different in comparison to installing any other Home Assistant add-on.

1. Search for "Chisel" in the Supervisor add-on store.
2. Install the "Chisel" add-on.
3. Configure the add-on according to your needs.
4. Start the add-on.

### Manual Installation

If the add-on is not available in the store, you can add this repository manually:

1. In Home Assistant, go to **Settings** → **Add-ons** → **Add-on Store**
2. Click the three dots in the top right corner
3. Select **Repositories**
4. Add this repository URL: `https://github.com/m2sh/ha-addon-chisel`
5. Install the "Chisel" add-on from the new repository

## Releases

This add-on follows [Semantic Versioning](https://semver.org/). For the latest releases, see the [GitHub releases page](https://github.com/m2sh/ha-addon-chisel/releases).

### Latest Release: v0.0.1

- **Initial release** with full server and client mode support
- **Multi-architecture support** (aarch64, amd64, armv7)
- **Comprehensive configuration options**
- **S6-overlay service management**

### Docker Images

The add-on is available as Docker images on GitHub Container Registry:

- `ghcr.io/m2sh/ha-addon-chisel:0.0.1-aarch64`
- `ghcr.io/m2sh/ha-addon-chisel:0.0.1-amd64`
- `ghcr.io/m2sh/ha-addon-chisel:0.0.1-armv7`

Latest versions are tagged as:
- `ghcr.io/m2sh/ha-addon-chisel:latest-aarch64`
- `ghcr.io/m2sh/ha-addon-chisel:latest-amd64`
- `ghcr.io/m2sh/ha-addon-chisel:latest-armv7`

## Configuration

### Server Mode

When running in server mode, Chisel acts as a tunnel server that clients can connect to.

```yaml
mode: "server"
server_port: 8080
server_keyfile: "/data/chisel.key"
server_authfile: "/data/users.json"
server_socks5: false
server_reverse: false
server_proxy: ""
server_header: []
log_level: "info"
verbose: false
```

#### Server Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `mode` | string | `"server"` | Operation mode (`server` or `client`) |
| `server_port` | integer | `8080` | Port to listen on |
| `server_keyfile` | string | `""` | Path to server key file (generated if not exists) |
| `server_authfile` | string | `""` | Path to authentication file |
| `server_socks5` | boolean | `false` | Enable SOCKS5 proxy |
| `server_reverse` | boolean | `false` | Enable reverse tunneling |
| `server_proxy` | string | `""` | Proxy server URL |
| `server_header` | list | `[]` | Custom HTTP headers |
| `log_level` | string | `"info"` | Log level (trace, debug, info, notice, warning, error, fatal) |
| `verbose` | boolean | `false` | Enable verbose logging |

### Client Mode

When running in client mode, Chisel connects to a remote server and creates tunnels.

```yaml
mode: "client"
client_server: "https://your-chisel-server.com:8080"
client_fingerprint: "your-server-fingerprint"
client_auth: "username:password"
client_remotes:
  - "8080:localhost:8123"
  - "socks"
client_keepalive: "25s"
client_max_retry_count: 0
client_max_retry_interval: "5m"
client_proxy: ""
client_header: []
client_hostname: ""
client_sni: ""
client_tls_ca: ""
client_tls_skip_verify: false
client_tls_key: ""
client_tls_cert: ""
log_level: "info"
verbose: false
```

#### Client Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `mode` | string | `"server"` | Operation mode (`server` or `client`) |
| `client_server` | string | `""` | Chisel server URL (required for client mode) |
| `client_fingerprint` | string | `""` | Server fingerprint for verification |
| `client_auth` | string | `""` | Authentication credentials (user:pass) |
| `client_remotes` | list | `[]` | Remote tunnel specifications (required for client mode) |
| `client_keepalive` | string | `"25s"` | Keepalive interval |
| `client_max_retry_count` | integer | `0` | Maximum retry count (0 = unlimited) |
| `client_max_retry_interval` | string | `"5m"` | Maximum retry interval |
| `client_proxy` | string | `""` | Proxy server URL |
| `client_header` | list | `[]` | Custom HTTP headers |
| `client_hostname` | string | `""` | Custom Host header |
| `client_sni` | string | `""` | Server Name Indication |
| `client_tls_ca` | string | `""` | TLS CA certificate path |
| `client_tls_skip_verify` | boolean | `false` | Skip TLS verification |
| `client_tls_key` | string | `""` | TLS client key path |
| `client_tls_cert` | string | `""` | TLS client certificate path |
| `log_level` | string | `"info"` | Log level (trace, debug, info, notice, warning, error, fatal) |
| `verbose` | boolean | `false` | Enable verbose logging |

## Usage Examples

### Example 1: Basic Server Setup

```yaml
mode: "server"
server_port: 8080
server_socks5: true
log_level: "info"
```

This creates a Chisel server on port 8080 with SOCKS5 proxy enabled.

### Example 2: Client Connecting to Remote Server

```yaml
mode: "client"
client_server: "https://your-server.com:8080"
client_fingerprint: "your-server-fingerprint"
client_remotes:
  - "8080:localhost:8123"
  - "socks"
client_keepalive: "30s"
```

This connects to a remote Chisel server and creates:
- A tunnel from remote port 8080 to local Home Assistant (port 8123)
- A SOCKS5 proxy on the remote server

### Example 3: Reverse Tunneling

```yaml
mode: "server"
server_port: 8080
server_reverse: true
server_authfile: "/data/users.json"
```

This creates a server that accepts reverse connections from clients.

### Example 4: Client with Authentication

```yaml
mode: "client"
client_server: "https://your-server.com:8080"
client_auth: "myuser:mypassword"
client_remotes:
  - "R:8080:localhost:8123"
client_fingerprint: "your-server-fingerprint"
```

This connects with authentication and creates a reverse tunnel.

## Authentication

### Server Authentication

Create a `users.json` file for server authentication:

```json
{
  "user1": "password1",
  "user2": "password2"
}
```

### Client Authentication

Use the `client_auth` option with format `username:password`.

## Security Considerations

1. **Fingerprint Verification**: Always use `client_fingerprint` to verify the server's identity
2. **Authentication**: Use strong passwords and authentication files
3. **TLS**: Enable TLS for additional security when possible
4. **Network Access**: Limit network access to the Chisel ports
5. **Key Management**: Securely store and manage server keys

## Troubleshooting

### Common Issues

1. **Connection Refused**: Check if the server is running and accessible
2. **Authentication Failed**: Verify username/password or auth file
3. **Fingerprint Mismatch**: Ensure the correct server fingerprint is used
4. **Port Already in Use**: Change the server port or stop conflicting services

### Logs

Check the add-on logs for detailed error messages and debugging information.

## Support

Got questions?

You have several options to get them answered:

- The [Home Assistant Community Add-ons Discord chat server][discord] for add-on support and feature requests.
- The [Home Assistant Discord chat server][discord-ha] for general Home Assistant discussions and questions.
- The Home Assistant [Community Forum][forum].
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

In case you've found a bug, please [open an issue on our GitHub repository][issue].

## Authors & contributors

The original setup of this repository is by [Mohammad Shahgolzadeh][m2sh].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

MIT License

Copyright (c) 2025 Mohammad Shahgolzadeh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[contributors]: https://github.com/m2sh/ha-addon-chisel/graphs/contributors
[discord-ha]: https://discord.gg/c5DvZ4e
[discord]: https://discord.gg/hZcXf9M
[forum]: https://community.home-assistant.io/
[issue]: https://github.com/m2sh/ha-addon-chisel/issues
[license-shield]: https://img.shields.io/github/license/m2sh/ha-addon-chisel.svg
[m2sh]: https://github.com/m2sh
[project-stage-shield]: https://img.shields.io/badge/project%20stage-production%20ready-brightgreen.svg
[reddit]: https://reddit.com/r/homeassistant
[releases-shield]: https://img.shields.io/github/release/m2sh/ha-addon-chisel.svg
[releases]: https://github.com/m2sh/ha-addon-chisel/releases
[repository]: https://github.com/m2sh/ha-addon-chisel
[buymeacoffee-shield]: https://www.buymeacoffee.com/assets/img/custom_images/black_img.png
[buymeacoffee]: https://www.buymeacoffee.com/m2sh 