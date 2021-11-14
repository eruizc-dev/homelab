# Homelab

Ultra compact home server machine, used for NAS and services

## Specs

### Hardware

 - Computer: Raspberry Pi 4B 8GB (arm64v8)
 - Case: Argon Neo
 - System drive: MicroSD SanDisk Ultra 32GB
 - Backup drive: MicroSD SanDisk Ultra 32GB with USB adaptor
 - Data drive: Seagate Expansion Stea4000400 4TB

### Software

 - OS: Raspberry Pi OS Lite (Bullseye arm64)
 - NAS: Open Media Vault 6
 - Container: Docker (check services in [docker-compose.yml](docker-compose.yml))

## TODO:

## Installation guide:

This is a rough guide on how to initially configure the sever. Security and
specifics are not covered so instructions on groups, users, volumes and other
are not provided.

### Open Media Vaul

I did it following this guide: <https://wiki.omv-extras.org/doku.php?id=installing_omv5_raspberry_pi>

TLDR;

Run this:

```bash
sudo apt-get update
sudo apt-get upgrade -y
sudo rm -f /etc/systemd/network/99-default.link
sudo reboot
```

Then this:

```bash
wget -O - https://github.com/OpenMediaVault-Plugin-Developers/installScript/raw/master/install | sudo bash

```

### Containers

You gotta install docker and docker-compose, luckily you can do that with apt

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose
```

Before running, you gotta disable `systemd-resolved` because it uses port 53 and
conflicts with pihole

```bash
systemctl stop systemd-resolved.service
systemctl disable systemd-resolved.service
```

### Tooling

I like having these tools when I log in to CLI

Lazydocker: works out of the box

```bash
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
```

Lazygit: it will install under `$HOME/go/bin/`, you gotta add that to `PATH`

```bash
sudo apt update
sudo apt install golang -y
go get github.com/jesseduffield/lazygit
```
