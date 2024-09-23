#!/usr/bin/env bash

set -eEuo pipefail

userspacePath="$1"

echo 'PATH="$HOME/.local/bin:$PATH"' >>$HOME/.bashrc && source $HOME/.bashrc
chmod +x "$userspacePath"/.devcontainer/setup.sh

sudo apt -y install usbutils
sudo apt -y install udev

wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
python3 -m pip install qmk
rm get-pip.py

python3 -m pip install --user --upgrade milc

git config --global --add safe.directory "$userspacePath"
# git submodule update --init --recursive

# qmk config user.qmk_home=/workspaces/qmk_firmware
# qmk config user.overlay_dir="$userspacePath"

# qmk git-submodule

qmk setup
sudo cp /workspaces/qmk_firmware/util/udev/50-qmk.rules /etc/udev/rules.d/
