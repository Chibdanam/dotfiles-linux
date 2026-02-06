#!/bin/bash
# Install database tools: lazysql

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

echo "Installing database tools..."

# lazysql
if is_installed lazysql; then
    echo -e "${YELLOW}[SKIP]${NC} lazysql already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} lazysql"
    yay -S --noconfirm lazysql
fi

echo "Database tools installation complete!"
