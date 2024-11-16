#!/usr/bin/env bash
set -euo pipefail

if [ -f "/run/.containerenv" ]
then
    function btrfs () {
        flatpak-spawn --host btrfs $*
    }
fi

if command -v bat >/dev/null
then
    btrfs filesystem usage / | bat -p -r 1:4 -r14: | grep -v '^$'
else
    btrfs filesystem usage / | sed -n '1,4p;14,20p' | grep -v '^$'
fi

echo ""
read -p "Proceed with create snapshots? [Y/n] " -n 1
echo ""

set +e
if [[ $REPLY =~ ^[Yy]$ ]] 
then
  sudo mount /mnt/snapshots
  sudo btrfs subvolume snapshot /sysroot /mnt/snapshots/root-$(date +%b-%d-%Y)
  sudo btrfs subvolume snapshot /home /mnt/snapshots/home-$(date +%b-%d-%Y)
  sudo umount /mnt/snapshots
else
  echo Creating snapshots Cancelled. If space is low, perform:
  echo sudo btrfs balance start -dusage=50 -musage=50 /
fi
set -e
