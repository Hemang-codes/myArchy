#!/bin/bash

# Configuration
DISK="/dev/sda"      # Verify with lsblk!
ARCH_PART="${DISK}3" # Tiny11 is usually 1 & 2 (EFI & Windows)
USER_NAME="hemang"
REPO="https://github.com/Hemang-codes/myArchy.git"

# 1. Format the Arch Partition (Keep EFI as is!)
mkfs.ext4 $ARCH_PART

# 2. Mount and Install Base
mount $ARCH_PART /mnt
mkdir -p /mnt/boot/efi
mount "${DISK}1" /mnt/boot/efi # Mounting your existing EFI partition
pacstrap /mnt base linux linux-firmware git nvim sudo

# 3. Generate fstab
genfstab -U /mnt >>/mnt/etc/fstab

# 4. System Config via Chroot
arch-chroot /mnt /bin/bash <<EOF
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
echo "arch-hemang" > /etc/hostname
useradd -m -G wheel $USER_NAME
echo "$USER_NAME:password" | chpasswd
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Pre-clone the repo for post-install
git clone $REPO /home/$USER_NAME/myArchy
chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/myArchy
EOF

echo "Done! Reboot, then run the script inside ~/myArchy."
