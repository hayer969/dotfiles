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
  - alter blanck screen timing

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

- `Firefox`:

  - Search engine - DuckDuckGo or Brave search
  - Extension - Privacy Badger
  - Extension - uBlock Origin
  - Extension - GNOME Shell integration
  - Extension - KeePassHelper Password Manager
  - Extension - Vimium-FF

- For remote control:

  - SSH Tunneling on client side:

        ssh -L {local_port}:localhost:{port on vnc server} -f -N {user_name}@{IP_address}

- `BTRFS` - mount option for long lifetime ssd, trim and noatime:  
  `noatime, discard=async, subvolumeid=ID`  
  use `btrfs subvolume list /` for **ID** and set this for `/home` partition

- `BTRFS` - subvolume operations, create subvolume for `/home` partition:

      btrfs subvolume create /sub1
      btrfs subvolume list /

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

      UUID={your uuid} /                       btrfs   rw,noatime,discard=async,ssd,space_cache,subvol=root,compress=zstd:1 0 0
      UUID={your uuid} /home                   btrfs   rw,noatime,discard=async,ssd,space_cache,subvol=home,compress=zstd:1 0 0
      UUID={your uuid} /mnt/toplevel/snapshots btrfs   noauto,rw,noatime,discard=async,ssd,space_cache,subvol=snapshots,compress=zstd:1 0 0
      UUID={your uuid} /var                    btrfs   rw,noatime,discard=async,ssd,space_cache,subvol=var,compress=zstd:1 0 0

- `Clamav`:

  - Install clamav in fedora: <https://www.linuxcapable.com/install-clamav-on-fedora-linux/>
  - Config for Russian IPs: <https://redos.red-soft.ru/base/manual/redos-manual/safe-redos/clamav/>

## OS tweaking

### For all

- vaapi (Video Acceleration API): https://fedoraproject.org/wiki/Firefox_Hardware_acceleration

  ### btrfs layots

  - root /
  - home /home
  - var /var
  - snapshots noauto-mount

## Windows 10

- X11-Server `VcXsrv`: <https://sourceforge.net/p/vcxsrv/wiki/Home/>

## Transition from Windows to Fedora

### Before transition I need to resolve some questions

- [x] Hunt Showdown should to be patched to work with proton/wine.
- [ ] Could I activate windows code on virtual machine repeatedly?
- [x] Gnome Boxes or VMware? Where it stores virtual disks?  
       Answer:  
       VMware, we have more settings for pci passthrough. And don't forgot to set `chattr +c` for images folder  
       or just check it with `lsattr`, fedora should do it automatically
- [x] Could I do flat layout of btrfs snapshots as on my arch?  
       What could be with grub after kernel updates?  
       Answer:  
       Yes, I can. If `/boot` and `/root` on the same subvolume it works as on arch.
- [x] How can I do snapshots before system updating?
      Should I use shell script or somehow connect GUI updater and timeshift for example?  
       Answer:  
       The easiest way, replace pacman command to dnf in existing script update_os.sh
- [x] Is BTRFS perfomance on HDD good?  
       Answer:  
       Good enough. Overall performance closest to ext4. But app start time maybe very poor with write/read opertaions on the background.
- [ ] Could I minimize applications to gnome tray?
      Autorun keyboard led managment app for Bloody hardware and minimize it.
      https://github.com/MartinPL/Tray-Icons-Reloaded
- [ ] How much space I need during transition process?
- [ ] XBOX controller with headphones, does it work?
- [x] OBS and Wayland, does it work?  
       Answer:  
       Yes, OBS Studio starts from version 27. It has rpm package in RPM Fusion Free Updates x86_64
- [x] Tekken 7 should work with proton/wine.  
       Answer:
      Maybe doesn't work with XEON proccessors.
- [x] Witcher 3, Assasins Creed, Wolfenstein should work with proton/wine.
- [ ] Blizzard Games should work with proton/wine.

---
