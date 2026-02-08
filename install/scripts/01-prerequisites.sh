#!/bin/bash
# Install prerequisites: build tools, git, yay (Arch), mise, rustup

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

DISTRO=$(detect_distro)

echo "Installing prerequisites..."

# System update
pkg_update

# Build tools (distro-specific package names)
case "$DISTRO" in
    arch)   pkg_install base-devel ;;
    ubuntu) pkg_install build-essential ;;
esac

# git
pkg_install git

# yay - AUR helper (Arch only, useful for ad-hoc AUR packages)
if [ "$DISTRO" = "arch" ]; then
    if is_installed yay; then
        echo -e "${YELLOW}[SKIP]${NC} yay already installed"
    else
        echo -e "${GREEN}[INSTALL]${NC} yay"
        cd /tmp
        git clone https://aur.archlinux.org/yay.git
        cd yay
        makepkg -si --noconfirm
        cd -
        rm -rf /tmp/yay
    fi
fi

# mise (universal installer works on both distros)
if is_installed mise; then
    echo -e "${YELLOW}[SKIP]${NC} mise already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} mise"
    curl https://mise.run | sh
    export PATH="$HOME/.local/bin:$PATH"
fi

# Ensure mise config is in place
MISE_CONFIG_DIR="$HOME/.config/mise"
MISE_CONFIG_SRC="$SCRIPT_DIR/../../mise/config.toml"

if [ -f "$MISE_CONFIG_SRC" ]; then
    mkdir -p "$MISE_CONFIG_DIR"
    if [ ! -L "$MISE_CONFIG_DIR/config.toml" ] || [ "$(readlink -f "$MISE_CONFIG_DIR/config.toml")" != "$(readlink -f "$MISE_CONFIG_SRC")" ]; then
        ln -sf "$(readlink -f "$MISE_CONFIG_SRC")" "$MISE_CONFIG_DIR/config.toml"
        echo -e "${GREEN}[LINK]${NC} mise config symlinked"
    else
        echo -e "${YELLOW}[SKIP]${NC} mise config already linked"
    fi
fi

# Install all tools defined in mise config
echo -e "${GREEN}[INSTALL]${NC} Installing mise tools (this may take a while)..."
mise install --yes

# Rust (via rustup - proper toolchain management)
if is_installed rustup; then
    echo -e "${YELLOW}[SKIP]${NC} rustup already installed"
else
    if is_installed cargo && ! is_installed rustup; then
        echo -e "${YELLOW}[WARNING]${NC} Rust installed without rustup. Consider removing system Rust first."
    fi
    echo -e "${GREEN}[INSTALL]${NC} rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

echo "Prerequisites installation complete!"
echo "Installed tools via mise:"
mise list
