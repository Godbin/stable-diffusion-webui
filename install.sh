#!/bin/bash

# Install Python 3.10.1
sudo apt-get update
sudo apt-get install -y python3.10.11

# Alias python3 to python3.10
alias python3=python3.10

sudo apt-get install libtcmalloc-minimal4
#&& export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH


# Add user "aa" with password "bb"
sudo adduser --disabled-password --gecos "" sf66
echo "sf66:S1679616n" | sudo chpasswd

# Switch to user "aa"
su - sf66

cd ~

weget https://github.com/Godbin/stable-diffusion-webui.git

cd ~/stable-diffusion-webui

rm -rf venv
python3 -m venv venv

source ~/stable-diffusion-webui/venv/bin/activate

# Find the path of the libtcmalloc.so file
path=$(find / -name "libtcmalloc.so.4" 2>/dev/null)

# Set LD_PRELOAD to preload the TCMalloc library
if [[ -n "$path" ]]; then
  echo "export LD_PRELOAD=$path" >> ~/.bashrc
  echo "LD_PRELOAD set to $path"
else
  echo "Could not find libtcmalloc.so"
fi
echo 'export PATH=$PATH:/usr/sbin"' >> ~/.bashrc

~/.bashrc
pip3 uninstall torch torchvision

pip3 install torch torchvision torchaudio

sh ~/webui.sh
