#!/bin/bash

# Install Python 3.10.1
sudo apt-get update
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev
wget https://www.python.org/ftp/python/3.10.11/Python-3.10.11.tgz
tar -xf Python-3.10.*.tgz
cd Python-3.10.*/
./configure --prefix=/usr/local --enable-optimizations --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
make -j $(nproc)
sudo make altinstall

# Check if Python 3.10 is already installed
if command -v python3.10 &>/dev/null; then
  echo "Python 3.10 is already installed"
else
  # Install dependencies
  sudo apt update
  sudo apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev

  # Download and install Python 3.10
  wget https://www.python.org/ftp/python/3.10.11/Python-3.10.11.tgz
  tar -xf Python-3.10.*.tgz
  cd Python-3.10.*/
  ./configure --prefix=/usr/local --enable-optimizations --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
  make -j $(nproc)
  sudo make altinstall
  # Check if Python 3.10 is installed
  if command -v python3.10 &>/dev/null; then
    echo "Python 3.10 installed successfully"
    pip3.10 install --user --upgrade pip
  else
    echo "Python 3.10 installation failed"
  fi
fi


# Alias python3 to python3.10
alias python3=python3.10

sudo apt-get install libtcmalloc-minimal4
#&& export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH


# Add user "aa" with password "bb"
sudo adduser --disabled-password --gecos "" sf66
echo "sf66:S1679616n" | sudo chpasswd

cd /home/sf66

wget https://github.com/Godbin/stable-diffusion-webui.git

cd /home/sf66/stable-diffusion-webui

rm -rf venv
mkdir /home/sf66/stable-diffusion-webui/venv
python3 -m venv venv

source /home/sf66/stable-diffusion-webui/venv/bin/activate

# Find the path of the libtcmalloc.so file
path=$(find / -name "libtcmalloc.so.4" 2>/dev/null)

# Set LD_PRELOAD to preload the TCMalloc library
if [[ -n "$path" ]]; then
  echo "export LD_PRELOAD=$path" >> /home/sf66/.bashrc
  echo "LD_PRELOAD set to $path"
else
  echo "Could not find libtcmalloc.so"
fi
echo 'export PATH=$PATH:/usr/sbin"' >> /home/sf66/.bashrc

/home/sf66/.bashrc
pip3 uninstall torch torchvision

pip3 install torch torchvision torchaudio
