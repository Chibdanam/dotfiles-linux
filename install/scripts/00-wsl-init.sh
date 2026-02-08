#!/bin/bash
# WSL initialization - run as root inside a fresh WSL instance (Arch or Ubuntu)
# This script: updates system, installs sudo, creates user, configures sudoers, writes wsl.conf
#
# Usage: wsl -d <distro> -u root -- bash install/scripts/00-wsl-init.sh

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

# Detect distro (inline — can't source lib.sh since this runs as root before setup)
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        arch|archarm|endeavouros|manjaro|omarchy) INIT_DISTRO="arch" ;;
        ubuntu|debian|linuxmint|pop)      INIT_DISTRO="ubuntu" ;;
        *)
            echo -e "${RED}[ERROR]${NC} Unsupported distro: $ID"
            exit 1
            ;;
    esac
else
    echo -e "${RED}[ERROR]${NC} Cannot detect distro (/etc/os-release not found)"
    exit 1
fi

echo -e "${GREEN}Detected distro:${NC} $INIT_DISTRO"

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
case "$INIT_DISTRO" in
    arch)   pacman -Syu --noconfirm ;;
    ubuntu) apt update && apt upgrade -y ;;
esac

# 2. Install sudo
echo -e "${GREEN}[INSTALL]${NC} sudo"
case "$INIT_DISTRO" in
    arch)   pacman -S --noconfirm --needed sudo ;;
    ubuntu) apt install -y sudo ;;
esac

# 3. Set root password
echo -e "${GREEN}[CONFIG]${NC} Setting root password"
echo "root:$ROOT_PASSWORD" | chpasswd

# 4. Create user with appropriate group
if id "$USERNAME" &>/dev/null; then
    echo -e "${YELLOW}[SKIP]${NC} User $USERNAME already exists"
else
    echo -e "${GREEN}[CONFIG]${NC} Creating user $USERNAME"
    case "$INIT_DISTRO" in
        arch)   useradd -m -G wheel -s /bin/bash "$USERNAME" ;;
        ubuntu) useradd -m -G sudo -s /bin/bash "$USERNAME" ;;
    esac
fi
echo "$USERNAME:$USER_PASSWORD" | chpasswd

# 5. Configure sudoers
echo -e "${GREEN}[CONFIG]${NC} Configuring sudo access"
case "$INIT_DISTRO" in
    arch)
        sed -i 's/^#.*%wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
        grep -q '^%wheel ALL=(ALL:ALL) ALL' /etc/sudoers || echo '%wheel ALL=(ALL:ALL) ALL' >> /etc/sudoers
        ;;
    ubuntu)
        grep -q '^%sudo' /etc/sudoers || echo '%sudo ALL=(ALL:ALL) ALL' >> /etc/sudoers
        ;;
esac

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
