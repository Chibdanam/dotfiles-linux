#!/bin/bash
# WSL Arch Linux initialization - run as root inside a fresh Arch WSL instance
# This script: updates system, installs sudo, creates user, configures sudoers, writes wsl.conf
#
# Usage: wsl -d archlinux -u root -- bash install/arch/00-wsl-init.sh

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Must run as root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}[ERROR]${NC} This script must be run as root."
    echo "Usage: wsl -d <distro> -u root -- bash $0"
    exit 1
fi

# Prompt for username and passwords
read -p "Username: " USERNAME
if [ -z "$USERNAME" ]; then
    echo -e "${RED}[ERROR]${NC} Username cannot be empty."
    exit 1
fi

read -s -p "Root password: " ROOT_PASSWORD
echo
read -s -p "Password for $USERNAME: " USER_PASSWORD
echo

# 1. Update system
echo -e "${GREEN}[UPDATE]${NC} Updating system packages"
pacman -Syu --noconfirm

# 2. Install sudo
echo -e "${GREEN}[INSTALL]${NC} sudo"
pacman -S --noconfirm --needed sudo

# 3. Set root password
echo -e "${GREEN}[CONFIG]${NC} Setting root password"
echo "root:$ROOT_PASSWORD" | chpasswd

# 4. Create user
if id "$USERNAME" &>/dev/null; then
    echo -e "${YELLOW}[SKIP]${NC} User $USERNAME already exists"
else
    echo -e "${GREEN}[CONFIG]${NC} Creating user $USERNAME"
    useradd -m -G wheel -s /bin/bash "$USERNAME"
fi
echo "$USERNAME:$USER_PASSWORD" | chpasswd

# 5. Configure sudoers for wheel group
echo -e "${GREEN}[CONFIG]${NC} Configuring sudo for wheel group"
sed -i 's/^#.*%wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
if ! grep -q '^%wheel ALL=(ALL:ALL) ALL' /etc/sudoers; then
    echo '%wheel ALL=(ALL:ALL) ALL' >> /etc/sudoers
fi

# 6. Write /etc/wsl.conf
echo -e "${GREEN}[CONFIG]${NC} Writing /etc/wsl.conf (systemd=true, default user=$USERNAME)"
cat > /etc/wsl.conf << EOF
[boot]
systemd=true

[user]
default=$USERNAME
EOF

# 7. Clear passwords from memory
ROOT_PASSWORD=""
USER_PASSWORD=""

echo ""
echo -e "${GREEN}WSL initialization complete!${NC}"
echo "Terminate and restart WSL to apply changes:"
echo "  wsl --terminate <distro>"
echo "  wsl -d <distro>"
