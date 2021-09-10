# System on my Desire PC
  
## Distro

+ **Linux** - minimal distribution `ArchLinux`
  + **FS** - `btrfs`  
  + **DE** - `gnome 40`

****  

## Shell & Terminal  

+ **shell** - `Fish`: <https://fishshell.com>
+ **terminal** - `Alacritty`: <https://github.com/alacritty/alacritty/blob/master/INSTALL.md>
+ **features** - `bobthefish` try not install, just edit fish.config: <https://github.com/oh-my-fish/theme-bobthefish>
+ **features** - `fuzzyfinder`: <https://github.com/junegunn/fzf>
+ **features** - `fd`: <https://github.com/sharkdp/fd>
+ **features** - `bat`: <https://github.com/sharkdp/bat>
+ **features** - `broot`: <https://dystroy.org/broot/install>
+ **features** - `lf`: <https://github.com/gokcehan/lf>
+ **features** - `tldr`: <https://github.com/tldr-pages/tldr>

+ **terminal text editor** - `neovim`: <https://github.com/neovim/neovim>

****

## Maintenance Arch

+ `gnome40` settings, use `gnome-tweaks` too:
  + add `ru` keyboard layot
  + set locale
  + set time
  + change shortcuts for preferable
  + alter blanck screen timing

+ Restrict log size

+ `gnome40` extensions:
  + Clipboard Indicator: <https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator>
  + Tiling Assistant: <https://github.com/Leleat/Tiling-Assist>

+ Firefox:
  + Search engine - DuckDuckGo or Brave search
  + Extension - Privacy Badger
  + Extension - uBlock Origin
  + Extension - GNOME Shell integration
  + Extension - KeePassHelper Password Manager
  + Extension - Vimium-FF

+ For remote control:
  + SSH Tunneling on client side:
  
        ssh -L {local_port}:localhost:{port on vnc server} -f -N {user_name}@{IP_address}

+ XRDP (not for Arch, but maybe works too):  
  #You have to use user name only with a_z letters, or xrdp won't work  
  #Next we modify the /etc/xrdp/xrdp.ini file to enable tls by changing "security_layer=rdp" to "security_layer=tls".  
  #And path to certificate and key_path  
  #Configure the policy xrdp session  

      cat > /etc/polkit-1/localauthority/50-local.d/45-allow-colord.pkla <<EOF
      [Allow Colord all Users]
      Identity=unix-user:*
      Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
      ResultAny=no
      ResultInactive=no
      ResultActive=yes
      EOF

  #sesman.ini  

      param=/usr/bin/Xorg

  #Then do cp command  

      sudo cp /usr/share/defaults/xrdp/startwm.sh /etc/xrdp/

  + Setup pam (fix login 0)

      sudo cp /usr/share/pam.d/xrdp-sesman /etc/pam.d/

      #Add next in wm_start():  
      `gnome-session --session=$DESKTOP-SESSION`

        systemctl start xrdp.service
        systemctl enable xrdp.service

+ BTRFS - mount option for long lifetime ssd, trim and noatime:  
`noatime, discard=async, subvolumeid=ID`  
use `btrfs subvolume list /` for **ID** and set this for `/home` partition  

+ BTRFS - subvolume operations, create subvolume for `/home` partition:  

      btrfs subvolume create /sub1
      btrfs subvolume list /

+ BTRFS - snapshots:  
  Create snapshot for root volume in dir `/snapshot`  

      sudo btrfs subvolume snapshot / /snapshot/root-{maybe_date}

  Delete snapshot or subvolume:  

      sudo btrfs subvolume delete {path to subvolume or snapshot}

  Suppose you make a big mess and you want to roll back to a known good state. It’s a good thing you made a snapshot before the mess happened. First unmount the mangled subvolume, then mount the snapshot in its place. If you decide you don’t need the mangled subvolume anymore you can delete it and rename the snapshot with the same name as the mangled subvolume, so you don’t have to change configuration files like /etc/fstab. Use our old friend the mv command for renaming:

      mv {path to snap} {path to subvolume}

+ BTRFS - disk usage:  

      btrfs filesystem du /{path}
      btrfs filesystem usage /{path}

+ BTRFS - fstab example:

      UUID={your uuid} /mnt/rootfs btrfs noauto,rw,noatime,discard=async,ssd,space_cache,compress=zstd:1,subvolid=5,subvol=/     0 0
      UUID={your uuid} /           btrfs rw,noatime,discard=async,ssd,space_cache,compress=zstd:1,subvol=/rootfs                 0 0

+ Pacman & paru:  
  paru install: <https://aur.archlinux.org/packages/paru/>  
  + update system  

        sudo pacman -Syu

  + update AUR packages only  

        paru -Sau

  + list foreign packages

        pacman -Qqm

  + list explicit packages (install by you)

        pacman -Qqen

  + list package own the file  

        pacman -Qo {file_path}

  + list files owned by package

        pacman -Ql {package_name}

  + clear packages with `paru`, `pacman` or list unrequired dependencies with `pacman`  

        paru -Sc
        pacman -Rs {package_name}
        pacman -Qqdt

  + clear package cache  

        pacman -Sc

## OS tweaks

+ auto-cpufreq: https://github.com/AdnanHodzic/auto-cpufreq
+ zram: https://fedoraproject.org/wiki/Changes/SwapOnZRAM
+ systemd-oomd: https://fedoraproject.org/wiki/Changes/EnableSystemdOomd#Enable_systemd-oomd_by_default_for_all_variants

## Windows 10

+ X11-Server `VcXsrv`: <https://sourceforge.net/p/vcxsrv/wiki/Home/>

****

## Other staff #TO DEL

+ Accelerated KVM guests on WSL 2 <https://boxofcables.dev/accelerated-kvm-guests-on-wsl-2>
+ Check WSL2 kernel for kvm <https://github.com/microsoft/WSL2-Linux-Kernel>
+ MacOs on KVM <https://github.com/foxlet/macOS-Simple-KVM>
+ Convert vdi to qcow2. <https://computingforgeeks.com/how-to-convert-virtualbox-disk-image-vdi-and-img-to-qcow2-format>
