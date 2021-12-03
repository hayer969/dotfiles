# System on my Desire PC
  
## Distro

+ **Linux** - `Fedora`
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
  + Gnome Shell Extensions: <https://gitlab.gnome.org/GNOME/gnome-shell-extensions>
  + Clipboard Indicator: <https://github.com/Tudmotu/gnome-shell-extension-clipboard-indicator>
  + Tiling Assistant: <https://github.com/Leleat/Tiling-Assist>
  + Blur my Shell: <https://github.com/aunetx/gnome-shell-extension-blur-my-shell>

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

## OS tweaking

+ auto-cpufreq: https://github.com/AdnanHodzic/auto-cpufreq
+ zram: https://fedoraproject.org/wiki/Changes/SwapOnZRAM
+ systemd-oomd: https://fedoraproject.org/wiki/Changes/EnableSystemdOomd#Enable_systemd-oomd_by_default_for_all_variants

## Windows 10

+ X11-Server `VcXsrv`: <https://sourceforge.net/p/vcxsrv/wiki/Home/>

## Transition from Windows to Fedora

### Before transition I need to resolve some questions  

+ [ ] Hunt Showdown & Crossout should to be patched to work with proton/wine.  
+ [ ] Could I activate windows code on virtual machine repeatedly?  
+ [x] Gnome Boxes or VMware? Where it stores virtual disks?  
     Answer:  
     VMware, we have more settings for pci passthrough. And don't forgot to set `chattr +c` for images folder  
     or just check it with `lsattr`, fedora should do it automatically  
+ [x] Could I do flat layout of btrfs snapshots as on my arch?  
     What could be with grub after kernel updates?  
     Answer:  
     Yes, I can. If `/boot` and `/root` on the same subvolume it works as on arch.
+ [x] How can I do snapshots before system updating?
     Should I use shell script or somehow connect GUI updater and timeshift for example?  
     Answer:  
     The easiest way, replace pacman command to dnf in existing script update_os.sh
+ [x] Is BTRFS perfomance on HDD good?  
     Answer:  
     Good enough. Overall performance closest to ext4. But app start time maybe very poor with write/read opertaions on the background.  
+ [ ] Could I minimize applications to gnome tray?
     Autorun keyboard led managment app for Bloody hardware and minimize it.
     https://github.com/MartinPL/Tray-Icons-Reloaded
+ [ ] How much space I need during transition process?  
+ [ ] XBOX controller with headphones, does it work?
+ [x] OBS and Wayland, does it work?  
     Answer:  
     Yes, OBS Studio starts from version 27. It has rpm package in RPM Fusion Free Updates x86_64  
+ [ ] Tekken 7 should work with proton/wine.  
     Answer:
     Maybe doesn't work with XEON proccessors.
+ [ ] PUBG, Rainbow Six Siege should work with proton/wine.  
+ [x] Witcher 3, Assasins Creed, Wolfenstein should work with proton/wine.  
+ [ ] Blizzard Games should work with proton/wine.  

****

## Other staff #TO DEL

+ Accelerated KVM guests on WSL 2 <https://boxofcables.dev/accelerated-kvm-guests-on-wsl-2>
+ Check WSL2 kernel for kvm <https://github.com/microsoft/WSL2-Linux-Kernel>
+ MacOs on KVM <https://github.com/foxlet/macOS-Simple-KVM>
+ Convert vdi to qcow2. <https://computingforgeeks.com/how-to-convert-virtualbox-disk-image-vdi-and-img-to-qcow2-format>
