#!/usr/bin/env bash
set -euxo pipefail

ls -1 ~/Applications/ > ~/dotfiles/fedora_settings/appimages_list.txt
dnf repoquery --userinstalled > ~/dotfiles/fedora_settings/dnf_list.txt
flatpak list | cut -f1,2 | tee ~/dotfiles/fedora_settings/flatpak_list.txt
ls -1 ~/.local/share/gnome-shell/extensions/ > gnome-extensions_list.txt

echo "Done!!!"
