# Install additional repo for 3-rd party packages

```bash
sudo dnf copr enable atim/starship
sudo dnf copr enable lihaohong/yazi
sudo dnf copr enable varlad/zellij
sudo dnf copr enable dejan/lazygit
sudo dnf config-manager setopt fedora-cisco-openh264.enabled=0
cat ./container_dnf_list.txt | sed "s/:.*\$//" | sed "s/-[0-9]*\$//" | xargs sudo dnf install -y
```
