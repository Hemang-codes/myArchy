#!/bin/bash

# Configuration
DISK="/dev/sda"      
# UPDATED: Using sda5 based on your last lsblk photo!
ARCH_PART="${DISK}5" 
USER_NAME="hemang"
REPO="https://github.com/Hemang-codes/myArchy.git"

# 1. Format and Mount
mkfs.ext4 $ARCH_PART
mount $ARCH_PART /mnt
mkdir -p /mnt/boot/efi
mount "${DISK}1" /mnt/boot/efi # Reusing your 512MB EFI partition

# 2. Pacstrap
pacstrap /mnt base linux linux-firmware intel-ucode git nvim sudo grub efibootmgr os-prober networkmanager ntfs-3g

# 3. Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# 4. Chroot Configuration
arch-chroot /mnt /bin/bash <<EOF
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "arch-hemang" > /etc/hostname
useradd -m -G wheel $USER_NAME
# REMEMBER: Change 'password' to your actual password after installation!
echo "$USER_NAME:password" | chpasswd
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Enable NetworkManager so you have Wi-Fi on reboot
systemctl enable NetworkManager

# GRUB Setup for Triple Boot
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux
grub-mkconfig -o /boot/grub/grub.cfg

# Pre-clone the repo for your GNU Stow setup
git clone $REPO /home/$USER_NAME/myArchy
chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/myArchy
EOF

echo "Installation complete! Rebooting in 5 seconds..."
sleep 5
reboot
