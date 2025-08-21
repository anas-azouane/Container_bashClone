#!/bin/bash
set -e

CONTAINER_ROOT=/mnt/debian # change to your corresponding rootfs location

sudo unshare \
  --mount \
  --uts \
  --ipc \
  --pid \
  --net \
  --fork \
  --mount-proc \
  bash -c "
    mount --make-rprivate /
    mount --rbind $CONTAINER_ROOT /mnt
    cd /mnt

    mount -t proc proc /mnt/proc
    mount --rbind /sys /mnt/sys
    mount --rbind /dev /mnt/dev

    hostname debian-container

    exec chroot /mnt /bin/bash
"

