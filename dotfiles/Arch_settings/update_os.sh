#!/bin/bash

#sudo btrfs fi show /dev/nvme0n1p2
#btrfs fi df /
btrfs filesystem usage / | bat -p -r 1:4 -r14: | grep -v '^$'
echo
#sudo btrfs fi show /dev/nvme0n1p3
#btrfs fi df /home/
btrfs filesystem usage /home | bat -p -r 1:4 -r14: | grep -v '^$'
echo 
read -p "Proceed with update? [Y/n] " answer
if [ "$answer" == "y" ] || [ "$answer" == "Y" ] || [ "$answer" == "yes" ] || [ "$answer" == "Yes" ] || [ "$answer" == "YES" ]
then
  sudo btrfs subvolume snapshot / /snapshot/root-$(date +%b-%d-%Y)
  sudo btrfs subvolume snapshot /home/ ~/.snapshot/home-$(date +%b-%d-%Y)
  sudo pacman -Syu
  paru -Sau
else
  echo Update Cancelled. If space is low, perform:
  echo sudo btrfs balance start -dusage=100 /
  echo sudo btrfs balance start -musage=100 /
fi
