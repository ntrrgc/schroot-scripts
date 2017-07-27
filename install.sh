#!/bin/bash
set -eu
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NAME="$(perl -ne '/\[(.*)\]/ && print $1' "$DIR/schroot-config/schroot.conf")"

sudo chown root: schroot-config/schroot.conf
sudo ln -s "$DIR/schroot-config/schroot.conf" "/etc/schroot/chroot.d/$NAME"
sudo ln -s "$DIR/schroot-config" "/etc/schroot/$NAME-config"
