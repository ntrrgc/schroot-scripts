#!/bin/bash
set -eu
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

REMOTE_MACHINE="$1"

sudo rsync -a --numeric-ids -P -z --rsync-path="sudo rsync" "$USER@$REMOTE_MACHINE:$DIR/chroot/" "$DIR/chroot/"

