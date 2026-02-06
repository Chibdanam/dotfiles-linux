#!/bin/bash
# Install CLI utilities via pacman (system-integrated with completions and man pages)

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

echo "Installing utilities..."

PACKAGES=(
    tmux
    unzip
    ripgrep
    bat
    eza
    fd
    sd
    fzf
    zoxide
    fastfetch
)

for pkg in "${PACKAGES[@]}"; do
    # Check by package name (some binaries differ from package name)
    if pacman -Qi "$pkg" &> /dev/null; then
        echo -e "${YELLOW}[SKIP]${NC} $pkg already installed"
    else
        echo -e "${GREEN}[INSTALL]${NC} $pkg"
        sudo pacman -S --noconfirm "$pkg"
    fi
done

echo "Utilities installation complete!"
