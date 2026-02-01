# Install WSL: Windows Subsystem for Linux

$ErrorActionPreference = "Stop"

function Install-WingetPackage {
    param([string]$PackageId, [string]$Name)

    $installed = winget list --id $PackageId 2>$null | Select-String $PackageId
    if ($installed) {
        Write-Host "[SKIP] $Name already installed" -ForegroundColor Yellow
    } else {
        Write-Host "[INSTALL] $Name" -ForegroundColor Green
        winget install --id $PackageId --source winget --accept-source-agreements --accept-package-agreements
    }
}

function Invoke-WslCommand {
    param([string]$Command)
    wsl -d $script:DistroName -u root -- bash -c $Command
    if ($LASTEXITCODE -ne 0) { throw "WSL command failed: $Command" }
}

Write-Host "Installing WSL..."

# Prompt for distribution name
$defaultName = "archlinux"
$inputName = Read-Host "Distribution name [$defaultName]"
$script:DistroName = if ($inputName) { $inputName } else { $defaultName }

# Install WSL
if (Get-Command wsl -ErrorAction SilentlyContinue) {
    Write-Host "[SKIP] Windows Subsystem for Linux already installed" -ForegroundColor Yellow
} else {
    Install-WingetPackage -PackageId "Microsoft.WSL" -Name "Windows Subsystem for Linux"
}

# Check if already installed
$distroList = wsl --list --quiet 2>$null
if ($distroList | Where-Object { $_ -eq $DistroName -or $_ -match "^$DistroName$" }) {
    Write-Host "[SKIP] $DistroName already installed" -ForegroundColor Yellow
    exit 0
}

# Install Arch Linux
Write-Host "[INSTALL] Arch Linux as '$DistroName'" -ForegroundColor Green
wsl --install archlinux --name $DistroName --no-launch


# Wait for distro to be accessible
Write-Host "Waiting for WSL instance..."
$retries = 0
while ($retries -lt 10) {
    $test = wsl -d $DistroName -- echo "ok" 2>$null
    if ($LASTEXITCODE -eq 0) { break }
    Start-Sleep -Seconds 2
    $retries++
}
if ($retries -eq 10) {
    Write-Host "[ERROR] Cannot access WSL instance. Try: wsl -d $DistroName" -ForegroundColor Red
    exit 1
}

# Get user credentials
Write-Host ""
$username = Read-Host "Username"
$rootPwd = Read-Host "Root password" -AsSecureString
$userPwd = Read-Host "Password for $username" -AsSecureString
$rootPwdPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($rootPwd))
$userPwdPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($userPwd))

# Configure system
Write-Host "[CONFIG] Updating system" -ForegroundColor Green
Invoke-WslCommand "pacman -Syu --noconfirm"

Write-Host "[CONFIG] Installing sudo" -ForegroundColor Green
Invoke-WslCommand "pacman -S --noconfirm --needed sudo"

Write-Host "[CONFIG] Setting root password" -ForegroundColor Green
Invoke-WslCommand "echo 'root:$($rootPwdPlain -replace "'","'\''")' | chpasswd"

Write-Host "[CONFIG] Creating user $username" -ForegroundColor Green
$userCheck = wsl -d $DistroName -u root -- id $username 2>$null
if ($LASTEXITCODE -ne 0) {
    Invoke-WslCommand "useradd -m -G wheel -s /bin/bash $username"
}
Invoke-WslCommand "echo '${username}:$($userPwdPlain -replace "'","'\''")' | chpasswd"

Write-Host "[CONFIG] Configuring sudo" -ForegroundColor Green
Invoke-WslCommand "sed -i 's/^#.*%wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers"
$wheelCheck = wsl -d $DistroName -u root -- grep -q '^%wheel ALL=(ALL:ALL) ALL' /etc/sudoers 2>$null
if ($LASTEXITCODE -ne 0) {
    Invoke-WslCommand "echo '%wheel ALL=(ALL:ALL) ALL' >> /etc/sudoers"
}

Write-Host "[CONFIG] Setting default user and enabling systemd" -ForegroundColor Green
Invoke-WslCommand "echo -e '[boot]\nsystemd=true\n\n[user]\ndefault=$username' > /etc/wsl.conf"

# Cleanup
$rootPwdPlain = $userPwdPlain = $null

# Restart to apply
wsl --terminate $DistroName

Write-Host ""
Write-Host "WSL Arch Linux installation complete!" -ForegroundColor Green
Write-Host "Start with: wsl -d $DistroName" -ForegroundColor Cyan
