#!/bin/bash
# Install database tools: lazysql (via go)

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

# Activate mise (for go)
if is_installed mise; then
    eval "$(mise activate bash)"
fi

echo "Installing database tools..."

# lazysql
if is_installed lazysql; then
    echo -e "${YELLOW}[SKIP]${NC} lazysql already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} lazysql"
    go install github.com/jorgerojas26/lazysql@latest
fi

echo "Database tools installation complete!"
