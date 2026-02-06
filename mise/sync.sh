#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../install/lib.sh"

DISTRO=$(detect_distro)
mkdir -p ~/.config/mise

if [ "$DISTRO" = "arch" ]; then
    CONFIG_FILE="$SCRIPT_DIR/config.arch.toml"
elif [ "$DISTRO" = "ubuntu" ]; then
    CONFIG_FILE="$SCRIPT_DIR/config.ubuntu.toml"
else
    echo -e "${YELLOW}[WARNING]${NC} Unknown distro '$DISTRO'. Defaulting to Arch config."
    CONFIG_FILE="$SCRIPT_DIR/config.arch.toml"
fi

ln -sf "$(readlink -f "$CONFIG_FILE")" ~/.config/mise/config.toml
echo "Synced mise config ($DISTRO) to ~/.config/mise/config.toml"
