# Debian Root Filesystem Container Script

This Bash script creates a lightweight, isolated Debian container environment using Linux namespaces and `chroot`. It's a simple alternative to Docker and other container runtimes (although not as sophisticated!)

## Overview

The script:
- Uses Linux namespaces (`unshare`) to isolate mount, UTS (hostname), IPC, PID, and network namespaces.
- Mounts a Debian root filesystem into a new namespace.
- Sets up necessary pseudo-filesystems (`/proc`, `/sys`, `/dev`) inside the container.
- Uses `chroot` to change the root directory to the Debian environment.
- Starts an interactive Bash shell inside the container.

## Prerequisites

- A valid Debian root filesystem extracted to a directory (e.g. via `debootstrap`):
  ```bash
  sudo debootstrap stable <your desired directory> http://deb.debian.org/debian
  ```
- bash, util-linux (for unshare), and appropriate permissions (sudo access).

## Notes

- Before running the script, make sure to edit the `CONTAINER_ROOT` variable to point to your Debian root filesystem.
- The script currently uses the `--net` flag to isolate the network namespace. However, network interfaces inside the container may not be up by default, which can prevent package installation or network access.
- To install packages or access the network inside the container, you can temporarily **remove** the `--net` flag from the script.
- After installing your desired packages, you can restore the `--net` flag to enable full network isolation.
- If you keep the `--net` flag enabled, you may need to manually bring up the loopback interface inside the container by running:
  ```bash
  ip link set lo up
  ``` 
