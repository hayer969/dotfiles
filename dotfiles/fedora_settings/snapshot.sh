#!/bin/bash

#sudo btrfs fi show /dev/nvme0n1p2
#btrfs fi df /
btrfs filesystem usage / | bat -p -r 1:4 -r14: | grep -v '^$'
echo ""
read -p "Proceed with create snapshots? [Y/n] " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]] 
then
  sudo mount /mnt/toplevel/snapshots
  sudo btrfs subvolume snapshot / /mnt/toplevel/snapshots/root-$(date +%b-%d-%Y)
  sudo btrfs subvolume snapshot /home /mnt/toplevel/snapshots/home-$(date +%b-%d-%Y)
  sudo umount /mnt/toplevel/snapshots
else
  echo Creating snapshots Cancelled. If space is low, perform:
  echo sudo btrfs balance start -dusage=50 -musage=50 /
fi
