#!/usr/bin/env bash
set -euxo pipefail

rpm-ostree status > ~/dotfiles/silverblue_settings/ostree.txt
ls -1 ~/Applications/ > ~/dotfiles/silverblue_settings/appimages_list.txt
toolbox run --container dev dnf repoquery --userinstalled > ~/dotfiles/silverblue_settings/container_dnf_list.txt
flatpak list --app | cut -f1,2 | tee 1>/dev/null ~/dotfiles/silverblue_settings/flatpak_list.txt
ls -1 ~/.local/share/gnome-shell/extensions/ > ~/dotfiles/silverblue_settings/gnome-extensions_list.txt

echo "Done!!!"
