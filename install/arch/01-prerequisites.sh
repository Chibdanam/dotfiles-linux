#!/bin/bash
# Install prerequisites: base-devel, git, yay, mise, rustup

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

echo "Installing prerequisites..."

# Update system first
echo -e "${GREEN}[UPDATE]${NC} Updating system packages"
sudo pacman -Syu --noconfirm

# Base development tools
if pacman -Qi base-devel &> /dev/null; then
    echo -e "${YELLOW}[SKIP]${NC} base-devel already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} base-devel"
    sudo pacman -S --noconfirm --needed base-devel
fi

# git
if is_installed git; then
    echo -e "${YELLOW}[SKIP]${NC} git already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} git"
    sudo pacman -S --noconfirm git
fi

# yay (AUR helper)
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

# mise (polyglot tool manager)
if is_installed mise; then
    echo -e "${YELLOW}[SKIP]${NC} mise already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} mise"
    yay -S --noconfirm mise
fi

# Ensure mise config is in place
MISE_CONFIG_DIR="$HOME/.config/mise"
MISE_CONFIG_SRC="$SCRIPT_DIR/../../mise/config.arch.toml"

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
        echo -e "${YELLOW}[WARNING]${NC} Rust installed via pacman. Consider removing with: sudo pacman -R rust"
    fi
    echo -e "${GREEN}[INSTALL]${NC} rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

echo "Prerequisites installation complete!"
echo "Installed tools via mise:"
mise list
