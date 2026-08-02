#!/usr/bin/env bash
set -euxo pipefail

rpm-ostree status > $PWD/ostree.txt
ls -1 ~/Applications/ > $PWD/appimages_list.txt
toolbox run --container dev dnf repoquery --userinstalled > $PWD/container_dnf_list.txt
flatpak list --app | cut -f1,2 | tee 1>/dev/null $PWD/flatpak_list.txt
ls -1 ~/.local/share/gnome-shell/extensions/ > $PWD/gnome-extensions_list.txt

: =====Done!!!=====
