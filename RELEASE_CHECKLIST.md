# Release Checklist

This document outlines the steps to create a new release of the Chisel Home Assistant Add-on.

## Pre-Release Checklist

- [ ] All features are implemented and tested
- [ ] Documentation is up to date
- [ ] Configuration examples are working
- [ ] Local builds are successful for all architectures
- [ ] GitHub Actions builds are passing
- [ ] No critical issues are open
- [ ] Changelog is updated

## Release Process

### 1. Prepare the Release

```bash
# Make sure you're on the main branch
git checkout main

# Pull latest changes
git pull origin main

# Run the release preparation script
./scripts/prepare-release.sh 1.0.0
```

The script will:
- Update version numbers in `config.yaml` and `Dockerfile`
- Commit the changes
- Create and push a git tag
- Trigger the GitHub Actions release workflow

### 2. Monitor the Release

1. Check the [GitHub Actions page](https://github.com/m2sh/ha-addon-chisel/actions)
2. Verify all architectures build successfully
3. Check that Docker images are pushed to GitHub Container Registry
4. Verify the GitHub release is created automatically

### 3. Post-Release Tasks

- [ ] Update the README.md with the new version number
- [ ] Update the CHANGELOG.md with the release date
- [ ] Test the addon installation from the new release
- [ ] Announce the release (if applicable)

## Version Numbering

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR** version for incompatible API changes
- **MINOR** version for backwards-compatible functionality additions
- **PATCH** version for backwards-compatible bug fixes

## Release Branches

- `main` - Development branch
- `v*` tags - Release tags

## Docker Images

Each release creates the following Docker images:

- `ghcr.io/m2sh/ha-addon-chisel:{version}-aarch64`
- `ghcr.io/m2sh/ha-addon-chisel:{version}-amd64`
- `ghcr.io/m2sh/ha-addon-chisel:{version}-armv7`

And latest tags:

- `ghcr.io/m2sh/ha-addon-chisel:latest-aarch64`
- `ghcr.io/m2sh/ha-addon-chisel:latest-amd64`
- `ghcr.io/m2sh/ha-addon-chisel:latest-armv7`

## Troubleshooting

### Build Failures

If builds fail:
1. Check the GitHub Actions logs for specific errors
2. Verify the Chisel version is available for all architectures
3. Test local builds to isolate issues
4. Check for changes in the base image or dependencies

### Release Creation Issues

If the release isn't created automatically:
1. Check that the tag was pushed correctly
2. Verify the GitHub Actions workflow is triggered
3. Check for any workflow errors
4. Manually create the release if needed

### Docker Image Issues

If Docker images aren't pushed:
1. Check GitHub Container Registry permissions
2. Verify the `GITHUB_TOKEN` has the necessary permissions
3. Check for Docker build errors
4. Verify the image tags are correct 