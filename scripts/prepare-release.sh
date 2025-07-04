#!/bin/bash

# Script to prepare a new release of the Chisel Home Assistant Add-on

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if version is provided
if [ $# -eq 0 ]; then
    print_error "Usage: $0 <version>"
    print_error "Example: $0 1.0.0"
    exit 1
fi

VERSION=$1

# Validate version format (semantic versioning)
if [[ ! $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    print_error "Version must be in semantic versioning format (e.g., 1.0.0)"
    exit 1
fi

print_status "Preparing release v$VERSION"

# Check if we're on main branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    print_warning "You're not on the main branch. Current branch: $CURRENT_BRANCH"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check if working directory is clean
if [ -n "$(git status --porcelain)" ]; then
    print_error "Working directory is not clean. Please commit or stash your changes."
    git status --short
    exit 1
fi

# Update version in config.yaml
print_status "Updating version in config.yaml"
sed -i.bak "s/version: .*/version: $VERSION/" chisel/config.yaml
rm chisel/config.yaml.bak

# Note: CHISEL_VERSION in Dockerfile should remain as the actual Chisel binary version
# (currently 1.10.1), not the addon version

# Commit the version changes
print_status "Committing version changes"
git add chisel/config.yaml
git commit -m "chore: bump version to $VERSION"

# Create and push the tag
print_status "Creating tag v$VERSION"
git tag -a "v$VERSION" -m "Release v$VERSION"

print_status "Pushing changes and tag"
git push origin main
git push origin "v$VERSION"

print_status "Release v$VERSION has been prepared and pushed!"
print_status "GitHub Actions will now build and release the addon."
print_status "You can monitor the progress at: https://github.com/m2sh/ha-addon-chisel/actions" 