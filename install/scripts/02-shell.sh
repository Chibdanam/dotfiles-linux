#!/bin/bash
# Install shell: zsh (git-delta provided by mise)

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

echo "Installing shell tools..."

# zsh
pkg_install zsh

# Set zsh as default shell
ZSH_PATH="$(which zsh)"
if [ "$SHELL" = "$ZSH_PATH" ]; then
    echo -e "${YELLOW}[SKIP]${NC} zsh already default shell"
else
    echo -e "${GREEN}[CONFIG]${NC} Setting zsh as default shell"
    sudo chsh -s "$ZSH_PATH" "$USER"
fi

# git-delta is provided by mise (see mise/config.toml)
echo -e "${YELLOW}[INFO]${NC} git-delta provided by mise"

echo "Shell tools installation complete!"
