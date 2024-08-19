# System on my Desire PC

## Distro

- **Linux** - `Fedora Silverblue`
  - **FS** - `btrfs`
  - **DE** - `gnome`

---

## Shell & Terminal

- **shell** - `Fish`: <https://fishshell.com>
- **terminal** - `Alacritty`: <https://github.com/alacritty/alacritty/blob/master/INSTALL.md>
- **features** - `starship` : <https://starship.rs/>
- **features** - `fuzzyfinder`: <https://github.com/junegunn/fzf>
- **features** - `fd`: <https://github.com/sharkdp/fd>
- **features** - `bat`: <https://github.com/sharkdp/bat>
- **features** - `jq`: <https://github.com/jqlang/jq>
- **features** - `yazi`: <https://github.com/sxyazi/yazi>
- **features** - `tldr`: <https://github.com/tldr-pages/tldr>
- **features** - `ripgrep`: <https://github.com/BurntSushi/ripgrep>
- **features** - `lazygit`: <https://github.com/jesseduffield/lazygit>
- **features** - `zoxide`: <https://github.com/ajeetdsouza/zoxide>

- **terminal text editor** - `neovim`: <https://github.com/neovim/neovim>

---

## Developing

- **python** - `virtualenv`: <https://virtualenv.pypa.io/en/latest/>

---

## Maintenance

- `gnome` settings, use `gnome-tweaks` too:

  - add `ru` keyboard layot
  - set locale
  - set time
  - change shortcuts for preferable
  - alter blank screen timing

- Restrict log size:
  Add in file `/etc/systemd/journald.conf` next strings:

      [Journal]
      SystemMaxUse=248M

- Create shared folders between users:

  - Create folder in place where all users can reach it. Usually at `/home`:

        mkdir /home/{name of shared folder}

  - Create group and add users:

        sudo groupadd sharedfolders
        sudo usermod -aG sharedfolders {user name}

  - Set permissions. All files will be created with particular rules and owned by the group

        sudo chmod g+rwxs {path to folder}
        setfacl -d -m group:sharedfolders:rwx {path to folder}

- `gnome` extensions:

  - Gnome Shell Extensions: <https://gitlab.gnome.org/GNOME/gnome-shell-extensions>
  - Clipboard history: <https://github.com/SUPERCILEX/gnome-clipboard-history>
  - Blur my Shell: <https://github.com/aunetx/gnome-shell-extension-blur-my-shell>
  - GSConnect: <https://github.com/GSConnect/gnome-shell-extension-gsconnect/wiki>
  - Tiling Shell: <https://github.com/domferr/tilingshell>

- `Firefox`:

  - Search engine - DuckDuckGo or Brave search
  - Extension - Privacy Badger
  - Extension - uBlock Origin
  - Extension - Vimium

- For remote control:

  - SSH Tunneling on client side:

        ssh -L {local_port}:localhost:{port on vnc server} -f -N {user_name}@{IP_address}

- `BTRFS` - mount option for long lifetime ssd, trim and noatime:
  `noatime, discard=async, subvolumeid=ID`
  use `btrfs subvolume list /` for **ID** and set this for `/home` partition

- `BTRFS` - subvolume operations, create subvolume for `/home` partition:

      btrfs subvolume create /sub1
      btrfs subvolume list /

- `BTRFS` - create root-level subvolume:

      sudo mkdir /mnt/btrfs/snapshots
      sudo mount /dev/disk/by-uuid/{your root device uuid} /mnt/btrfs
      cd /mnt/btrfs
      sudo btrfs subvolume create snapshots
      cd /home
      sudo umount /mnt/btrfs

- `BTRFS` - snapshots:
  Create snapshot for root volume in dir `/snapshot`

      sudo btrfs subvolume snapshot / /snapshot/root-{maybe_date}

  Delete snapshot or subvolume:

      sudo btrfs subvolume delete {path to subvolume or snapshot}

  Suppose you make a big mess and you want to roll back to a known good state. It’s a good thing you made a snapshot before the mess happened. First unmount the mangled subvolume, delete mangled subvolume, create snapshot from backup one with name mangled subvolume:

      sudo btrfs subvolume delete {path to mangled subvolume}
      sudo btrfs subvolume snapshot {path to backup snapshot} {path to mangled subvolume}

  Fedora specific, after rollback root partition it is better to clear gnome-software-center cache:

      sudo pkcon refresh force -c -1

- `BTRFS` - disk usage:

      btrfs filesystem du /{path}
      btrfs filesystem usage /{path}

- `BTRFS` - fstab example:

      UUID={your uuid} /                       btrfs   rw,noatime,discard=async,ssd,subvol=root,compress=zstd:1 0 0
      UUID={your uuid} /home                   btrfs   rw,noatime,discard=async,ssd,subvol=home,compress=zstd:1 0 0
      UUID={your uuid} /mnt/toplevel/snapshots btrfs   noauto,rw,noatime,discard=async,ssd,subvol=snapshots,compress=zstd:1 0 0
      UUID={your uuid} /var                    btrfs   rw,noatime,discard=async,ssd,subvol=var,compress=zstd:1 0 0

- `Clamav`:

  - Install clamav in fedora (clamav, clamav-freshclam): <https://www.linuxcapable.com/install-clamav-on-fedora-linux/>
  - Config for Russian IPs: <https://redos.red-soft.ru/base/manual/redos-manual/safe-redos/clamav/>

        sudo vi /etc/freshclam.conf
        # DatabaseMirror database.clamav.net
        DatabaseMirror https://packages.microsoft.com/clamav/

- `KVRT` kaspersky virus removal tool:

  - Need to be downloaded every time: <https://www.kaspersky.com/downloads/free-virus-removal-tool>

## OS tweaking

### Hardware video acceleration

- vaapi (Video Acceleration API): https://fedoraproject.org/wiki/Firefox_Hardware_acceleration

### btrfs layots

- root /
- home /home
    - steam /home/steam
    - games /home/games
- var /var
- snapshots *noauto-mount*

### Fedora Silverblue Post Installation Guide

- Link: <https://lurkerlabs.com/fedora-silverblue-ultimate-post-install-guide/>

### Gnome folder sharing aka Public folder

- To find right path for shared folder do `avahi-browse -fart`  
Then in nautilus `Other location -> Enter server address` fill with `dav://address:port`  
*In host: share should be enabled and port allowed through firewall*


### Check if we're running inside a toolbox and switch home folder

```bash
TOOLBOX_NAME=""
if [ -f "/run/.containerenv" ]
then
    TOOLBOX_NAME=$(sed -nr 's/^name="(.*)"$/\1/p' /run/.containerenv)
    HOME="$HOME/.toolbox/homedir/$TOOLBOX_NAME/$USER"
    mkdir -p "$HOME"
    bash
    exit 0
fi
```

### Flatpak

- Check size of installed apps, using custom fish function: `flatpsize`
- Uninstall unused: `flatpak uninstall --unused`
- Flatpak updated installed: `flatpak update`

### IPsec VPN with strongswan

- Link your system ssl certificates to folder where strongswan looks up it .  

      sudo ln -s /etc/pki/ca-trust/extracted/pem/ /etc/strongswan/ipsec.d/cacerts

*For Silverblue it can't merge `/etc/...cacerts` folder. Instead create link to contents of the folder.*

### Login screen on major monitor

    sudo cp -v ~/.config/monitors.xml /var/lib/gdm/.config/
    sudo chown gdm:gdm /var/lib/gdm/.config/monitors.xml

### Show system temperature (two ways)

    watch "sensors -A 2>/dev/null"
    watch "fastfetch --cpu-temp --gpu-temp | grep -E \"CPU|GPU\" | sed 's/:.* -/:/'"

### Show folders size with bash

    find ./ -maxdepth 3 -type d -iname "*" -exec du -sh {} \; | sort -h

### Disable **gfxoff** in amdgpu drivers. If your system kinda suspend and never wake up
See `enum PP_FEATURE_MASK` <https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/include/amd_shared.h#L183>

    sudo rpm-ostree kargs --append='amdgpu.ppfeaturemask=0xfffd3fff'

### Install opencl with amdgpu drivers.

Do: `groups`  you should see `video` and `render` as well as your user,  
if it's not, then copy it and install `rocm` packages:

    sudo cat /lib/group | grep -E "video|render" >> /etc/group
    sudo rpm-ostree install rocm-opencl rocm-opencl-devel rocm-hip rocm-hip-devel

*rocm-hip and rocm-hip-devel doesn't work for me with blender*

### Smart info about nvme ssd

    sudo nvme smart-log /dev/nvme0n1



## Windows 10

- X11-Server `VcXsrv`: <https://sourceforge.net/p/vcxsrv/wiki/Home/>
