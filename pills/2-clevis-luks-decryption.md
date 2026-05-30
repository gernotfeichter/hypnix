# Pill 2: Clevis LUKS Decryption with Android

This guide explains how to configure `clevis` together with the Android `tanga` app for automated LUKS disk decryption. This process allows your Android device to securely provide the decryption key to your hypnix system via a network connection during early boot.

## Prerequisites

1. An android device running the [tanga](https://github.com/gernotfeichter/tanga) application (for Tang server support).
2. You must have already configured LUKS encryption on your system. This is the case when you selected "Encrypt Disk" with a password during the installation.
3. Your android device's IP address should ideally be static or assigned a fixed DHCP lease. Using the device Name may be another option, but afaik this feature is android version dependendent.
4. Your android device is connected to the same network as your hypnix machine.

---

## Setting up Clevis LUKS Decryption

To unlock your LUKS disk at boot, we use `clevis` configured as a Tang client in early-boot (`initrd`). The Android device (via the `tanga` app) will act as the Tang server.

Edit the file hardware/\<machine-name\>/clevis-luks.nix to enable and configure unlocking.
```
let
  enabled = true;
  interfaceWifi = "wlp0s20u5"; # Adjust to your Wi-Fi interface, if necessary, run: ip addr to see available interfaces
  interfaceEth = "enp7s0"; # Adjust to your ethernet interface, if necessary, run: ip addr to see available interfaces
```

> **Note**: This file already includes the necessary overrides to establish networking in `initrd` (which is required because your hypnix machine needs to communicate with the Android device during early boot). Consider commenting out wifi options when using ethernet, and vice versa.

When using WIFI, you must also configure the ssid and password in `/etc/nixos/hardware/<your-machine-name>/secrets/wpa_supplicant.conf`!

Make sure that only root can read this file, e.g. by running: `chmod 600 /etc/nixos/hardware/<your-machine-name>/secrets/wpa_supplicant.conf`

### Binding the Tang Server

1. Obtain the IP and port from the `tanga` app (e.g. `192.168.1.100:7654`).
2. Bind your LUKS disk to the Tang server:
   ```bash
   # Replace /dev/disk/by-uuid/<your-luks-uuid> with your actual encrypted partition, same for the IP address
   # Hint: You can find your luks uuid by running: lsblk, if you have multiple partitions, pick one, if installed with the standard hypnix installer, all off them will use the same passphrase
   sudo su
   echo -n '<your luks passphrase>' | clevis encrypt tang '{"url": "http://<your tang server>:7500"}' > /etc/nixos/hardware/<your-machine-name>/secrets/luks.jwe
   ```
   *This process will prompt you for your current LUKS passphrase and then ask the tang server for the keys to generate a new JWE token.*
3. `nixos-rebuild switch --impure`

Next time you boot, `initrd` will wait for an internet connection, connect to the Tang server on your phone, and automatically decrypt the disk.
