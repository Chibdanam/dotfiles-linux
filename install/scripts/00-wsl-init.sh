#!/bin/bash
# WSL initialization - run as root inside a fresh WSL instance (Arch or Ubuntu)
# Idempotent: safe to run multiple times. Skips steps already completed.
#
# Usage: wsl -d <distro> -u root -- bash install/scripts/00-wsl-init.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib.sh"

# Must run as root
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${RED}[ERROR]${NC} This script must be run as root."
    echo "Usage: wsl -d <distro> -u root -- bash $0"
    exit 1
fi

DISTRO=$(detect_distro)
echo -e "${GREEN}Detected distro:${NC} $DISTRO"

# Detect existing non-root user (UID >= 1000)
EXISTING_USER=$(awk -F: '$3 >= 1000 && $1 != "nobody" { print $1; exit }' /etc/passwd)

if [ -n "$EXISTING_USER" ]; then
    USERNAME="$EXISTING_USER"
    echo -e "${YELLOW}[SKIP]${NC} User $USERNAME already exists"
    NEED_USER_CREATION=false
else
    read -p "Username: " USERNAME
    if [ -z "$USERNAME" ]; then
        echo -e "${RED}[ERROR]${NC} Username cannot be empty."
        exit 1
    fi
    NEED_USER_CREATION=true
fi

# Only prompt for passwords when creating a new user
if [ "$NEED_USER_CREATION" = true ]; then
    while true; do
        read -s -p "Root password: " ROOT_PASSWORD
        echo
        read -s -p "Root password (confirm): " ROOT_PASSWORD_CONFIRM
        echo
        [ "$ROOT_PASSWORD" = "$ROOT_PASSWORD_CONFIRM" ] && break
        echo -e "${RED}Passwords do not match. Try again.${NC}"
    done

    while true; do
        read -s -p "Password for $USERNAME: " USER_PASSWORD
        echo
        read -s -p "Password for $USERNAME (confirm): " USER_PASSWORD_CONFIRM
        echo
        [ "$USER_PASSWORD" = "$USER_PASSWORD_CONFIRM" ] && break
        echo -e "${RED}Passwords do not match. Try again.${NC}"
    done
fi

# 1. Update system
echo -e "${GREEN}[UPDATE]${NC} Updating system packages"
case "$DISTRO" in
    arch)   pacman -Syu --noconfirm ;;
    ubuntu) apt update && apt upgrade -y ;;
esac

# 2. Install sudo
if is_installed sudo; then
    echo -e "${YELLOW}[SKIP]${NC} sudo already installed"
else
    echo -e "${GREEN}[INSTALL]${NC} sudo"
    case "$DISTRO" in
        arch)   pacman -S --noconfirm --needed sudo ;;
        ubuntu) apt install -y sudo ;;
    esac
fi

# 3. Create user and set passwords (only on fresh setup)
if [ "$NEED_USER_CREATION" = true ]; then
    echo -e "${GREEN}[CONFIG]${NC} Setting root password"
    echo "root:$ROOT_PASSWORD" | chpasswd

    echo -e "${GREEN}[CONFIG]${NC} Creating user $USERNAME"
    case "$DISTRO" in
        arch)   useradd -m -G wheel -s /bin/bash "$USERNAME" ;;
        ubuntu) useradd -m -G sudo -s /bin/bash "$USERNAME" ;;
    esac
    echo "$USERNAME:$USER_PASSWORD" | chpasswd

    # Clear passwords from memory
    ROOT_PASSWORD=""
    USER_PASSWORD=""
fi

# 4. Configure sudoers
echo -e "${GREEN}[CONFIG]${NC} Configuring sudo access"
case "$DISTRO" in
    arch)
        if grep -q '^%wheel ALL=(ALL:ALL) ALL' /etc/sudoers; then
            echo -e "${YELLOW}[SKIP]${NC} wheel group already enabled in sudoers"
        elif grep -q '^#.*%wheel ALL=(ALL:ALL) ALL' /etc/sudoers; then
            sed -i 's/^#.*%wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
            echo -e "${GREEN}[CONFIG]${NC} Uncommented wheel group in sudoers"
        else
            echo '%wheel ALL=(ALL:ALL) ALL' >> /etc/sudoers
            echo -e "${GREEN}[CONFIG]${NC} Added wheel group to sudoers"
        fi
        ;;
    ubuntu)
        if grep -q '^%sudo' /etc/sudoers; then
            echo -e "${YELLOW}[SKIP]${NC} sudo group already in sudoers"
        else
            echo '%sudo ALL=(ALL:ALL) ALL' >> /etc/sudoers
            echo -e "${GREEN}[CONFIG]${NC} Added sudo group to sudoers"
        fi
        ;;
esac

# 5. Write /etc/wsl.conf (only if content differs)
DESIRED_WSL_CONF="[boot]
systemd=true

[user]
default=$USERNAME"

if [ -f /etc/wsl.conf ] && [ "$(cat /etc/wsl.conf)" = "$DESIRED_WSL_CONF" ]; then
    echo -e "${YELLOW}[SKIP]${NC} /etc/wsl.conf already correct"
else
    echo -e "${GREEN}[CONFIG]${NC} Writing /etc/wsl.conf (systemd=true, default user=$USERNAME)"
    echo "$DESIRED_WSL_CONF" > /etc/wsl.conf
fi

echo ""
echo -e "${GREEN}WSL initialization complete!${NC}"
echo "Terminate and restart WSL to apply changes:"
echo "  wsl --terminate <distro>"
echo "  wsl -d <distro>"
