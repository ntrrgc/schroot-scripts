#!/bin/bash
set -eu
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NAME="$(perl -ne '/\[(.*)\]/ && print $1' "$DIR/schroot-config/schroot.conf")"

cd "$DIR"
./begin-session.sh 2> /dev/null || true

# Create user first
./run-session.sh -u root -d / bash << EOF
useradd -m ntrrgc || true
EOF

# Copy SSH keys
cp -r ~/.ssh chroot/home/ntrrgc/

./run-session.sh -u root -d / bash << EOF
set -eu

chown -R ntrrgc: /home/ntrrgc/.ssh # just in case UIDs don't match

apt install -y sudo vim-nox silversearcher-ag make python binutils htop \
  graphviz g++ perl-base locales jq time git ccache

echo "export EDITOR=vi" > /etc/profile.d/editor.sh
echo "export LANG='en_US.UTF-8'" > /etc/profile.d/locale.sh
echo 'export PATH="/usr/lib/ccache:\$PATH"' > /etc/profile.d/ccache.sh

grep -q "ntrrgc" /etc/sudoers || echo "ntrrgc ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

# We need some locales built because otherwise the system has no defined 
# encoding and things can go wrong easily (e.g. Python crashes when opening
# in text mode any file that has non-ASCII characters).
sed -i '/^# en_US.UTF-8/s/^#//' /etc/locale.gen
locale-gen

# Install my beloved dotfiles
sudo -u ntrrgc bash << USER

set -eu
cd
if [ ! -d dotfiles ]; then
  git clone git@github.com:ntrrgc/dotfiles.git
  cd dotfiles
  rm ../.bashrc
  ./install.sh
fi

USER
EOF
