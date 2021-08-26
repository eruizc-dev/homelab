#!/bin/bash

# Update system
sudo apt update && sudo apt upgrade -y

# Install lazydocker
curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

