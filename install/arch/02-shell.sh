#!/bin/bash
# Install shell tools: zsh, git-delta

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

echo "Installing shell tools..."

# zsh
if is_installed zsh; then
    echo -e "${YELLOW}[SKIP]${NC} zsh already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} zsh"
    sudo pacman -S --noconfirm zsh
fi

# Set zsh as default shell
if [ "$SHELL" = "/usr/bin/zsh" ]; then
    echo -e "${YELLOW}[SKIP]${NC} zsh already default shell"
else
    echo -e "${GREEN}[CONFIG]${NC} Setting zsh as default shell"
    chsh -s /usr/bin/zsh
fi

# git-delta (better git diffs)
if is_installed delta; then
    echo -e "${YELLOW}[SKIP]${NC} git-delta already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} git-delta"
    sudo pacman -S --noconfirm git-delta
fi

echo "Shell tools installation complete!"
