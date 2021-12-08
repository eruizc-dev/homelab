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

## TODOs

 1. Backup data drive to the cloud (AWS Glacier maybe)
 2. SMTP server for vaultwarden emails and grafana alerts
 3. Home Assistant to be able to turn on/off my lights without having to connect to the internet
 4. Backup my volumes to the cloud (in form of daily snapshots, keep for a month):
   <https://dev.to/hendr_ik/automate-backing-up-your-docker-volumes-3gdk>
 5. Backup system drive to the cloud (in form of weekly snapshots, keep for a month)
 6. Encrypt system and data drives
 7. Setup grafana alerts
 8. Uptime kuma <https://github.com/louislam/uptime-kuma> for checking service uptime (and send notifications)
 9. Get a UPS
 10. Setup VPN to access my services remotely

## Installation guide:

This is a rough guide on how to initially configure the sever. Security and
specifics are not covered so instructions on groups, users, volumes and other
are not provided.

### Open Media Vault

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
