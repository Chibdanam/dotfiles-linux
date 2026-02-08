#!/bin/bash
# Install dev core: cmake, python, docker

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

DISTRO=$(detect_distro)

echo "Installing dev core tools..."

# cmake
pkg_install cmake

# python + pip (distro-specific package names)
case "$DISTRO" in
    arch)
        pkg_install python
        pkg_install python-pip
        ;;
    ubuntu)
        pkg_install python3
        pkg_install python3-pip
        pkg_install python3-venv
        ;;
esac

# docker (universal installer)
if is_installed docker; then
    echo -e "${YELLOW}[SKIP]${NC} docker already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} docker"
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker "${SUDO_USER:-$USER}"
    echo "Note: Log out and back in for docker group to take effect"
fi

echo "Dev core tools installation complete!"
