#!/bin/bash

#sudo btrfs fi show /dev/nvme0n1p2
#btrfs fi df /
btrfs filesystem usage / | bat -p -r 1:4 -r14: | grep -v '^$'
echo ""
#sudo btrfs fi show /dev/nvme0n1p3
#btrfs fi df /home/
btrfs filesystem usage /home | bat -p -r 1:4 -r14: | grep -v '^$'
echo ""
read -p "Proceed with update? [Y/n] " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]] 
then
  sudo mount /mnt/rootfs
  sudo btrfs subvolume snapshot /mnt/rootfs/rootfs /mnt/rootfs/snapshots/root-$(date +%b-%d-%Y)
  sudo umount /mnt/rootfs
  sudo mount /mnt/homefs
  sudo btrfs subvolume snapshot /mnt/homefs/homefs/ /mnt/homefs/snapshots/home-$(date +%b-%d-%Y)
  sudo umount /mnt/homefs
  sudo pacman -Syu
  paru -Sau
else
  echo Update Cancelled. If space is low, perform:
  echo sudo btrfs balance start -dusage=50 /
  echo sudo btrfs balance start -musage=50 /
fi
