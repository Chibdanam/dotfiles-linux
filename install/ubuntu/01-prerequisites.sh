#!/bin/bash
# Install prerequisites: git, build-essential, mise (polyglot tool manager), rustup

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

echo "Installing prerequisites..."

# git
if is_installed git; then
    echo -e "${YELLOW}[SKIP]${NC} git already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} git"
    sudo apt update
    sudo apt install -y git
fi

# build-essential (g++, gcc, make)
if is_installed g++; then
    echo -e "${YELLOW}[SKIP]${NC} build-essential already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} build-essential"
    sudo apt install -y build-essential
fi

# mise
if is_installed mise; then
    echo -e "${YELLOW}[SKIP]${NC} mise already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} mise"
    curl https://mise.run | sh
    # Add to PATH for current session
    export PATH="$HOME/.local/bin:$PATH"
fi

# Ensure mise config is in place
MISE_CONFIG_DIR="$HOME/.config/mise"
MISE_CONFIG_SRC="$SCRIPT_DIR/../../mise/config.ubuntu.toml"

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
    echo -e "${GREEN}[INSTALL]${NC} rustup"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

echo "Prerequisites installation complete!"
echo "Installed tools via mise:"
mise list
