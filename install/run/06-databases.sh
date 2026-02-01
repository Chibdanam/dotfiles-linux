#!/bin/bash
# Install database tools: postgresql-libs (client)

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

is_installed() {
    command -v "$1" &> /dev/null
}

echo "Installing database tools..."

# postgresql (client tools)
if is_installed psql; then
    echo -e "${YELLOW}[SKIP]${NC} postgresql already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} postgresql (client)"
    yay -Syu --noconfirm postgresql-libs
fi

echo "Database tools installation complete!"
