#!/bin/bash
set -eu
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
NAME="$(perl -ne '/\[(.*)\]/ && print $1' "$DIR/schroot-config/schroot.conf")"

schroot --begin-session -c "$NAME" -n "$NAME-session"
