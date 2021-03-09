#!/bin/bash
sudo btrfs subvolume snapshot / /snapshot/root-$(date +%b-%d-%Y)
sudo btrfs subvolume snapshot /home/ ~/.snapshot/home-$(date +%b-%d-%Y)
sudo pacman -Syu
paru -Sau
