#!/bin/bash
set -eu
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NAME="$(perl -ne '/\[(.*)\]/ && print $1' "$DIR/schroot-config/schroot.conf")"

schroot --begin-session -c "$NAME" -n "$NAME-session"

# Allow X11 clients to use the server outside the chroot
sudo cp -f "$HOME/.Xauthority" "$DIR/chroot/" || true
cat << EOF | sudo tee "$DIR/chroot/etc/profile.d/x11.sh" > /dev/null
export XAUTHORITY=/.Xauthority
export DISPLAY="${DISPLAY:-}"
EOF

# Make /dev/shm world-writable inside the chroot.
# devtmpfs mounts may start out with the shm directory as read only.
sudo chmod 777 "$DIR/chroot/dev/shm"
