These are a few scripts I use for creating and installing schroot environments.

## Setup

1. Clone this repository somewhere.

2. Edit `schroot/schroot.conf` in order to set a name for the chroot, give your user permission rights and so on.

3. Use debootstrap to install something Debian-based.

        sudo debootstrap --arch=amd64 stretch $PWD/chroot http://ftp.fr.debian.org/debian/

4. Install the profile in `/etc/schroot`.

        ./install.sh

5. Give a look at `typical-chroot-setup.sh`, modify it accordingly and run it (outside the chroot) in order to have something more usable.

        ./typical-chroot-setup.sh

## Usage

Prepare the chroot for use:

    ./begin-session.sh

Run commands in the chroot:

    ./run-session.sh [ -u <user> ] [ -d <directory> ] [ <command> ]

End the schroot session (remove mountpoints):

    ./end-session.sh
