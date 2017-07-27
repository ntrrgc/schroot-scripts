#!/bin/bash
set -eu
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NAME="$(perl -ne '/\[(.*)\]/ && print $1' "$DIR/schroot-config/schroot.conf")"

# Note: Use ./run-session.sh -u root -d / to run as root.

schroot --run-session -c "$NAME-session" "$@"
