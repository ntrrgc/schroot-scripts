#!/bin/bash
set -eu
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NAME="$(perl -ne '/\[(.*)\]/ && print $1' "$DIR/schroot-config/schroot.conf")"

schroot --end-session -c "$NAME-session" || (
  # Force end session (e.g. if previously shut down without calling this script)
  sudo rmdir /var/lib/schroot/mount/ntrrgc-webkit-session/
  sudo rm /var/lib/schroot/session/ntrrgc-webkit-session
)
