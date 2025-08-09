# fork

> WIP: This is currently under development and not usable!

This folder contains this forked repo state: https://github.com/NixOS/calamares-nixos-extensions/releases/tag/0.3.19.

The code in this folder contains the calameres (nixos installation program - live installer) config and customizations for nixos and respective for hypnix on top of that.
Hypnix is basically just a NixOS config seeder (installer).
After you installed Hpynix, you just have a NixOS with your custom configuration.

Notable changes after forking:
- The original README was renamed to [README_original.md](README_original.md).
- Non-relevant desktop environments were removed from config files, not so from the code (should not hurt much), to reduce git conflict potential of this fork.
- The default size of the `/boot` partition was increased from `512MB` to `5GB` to avoid the common error `No space left on /boot` - https://discourse.nixos.org/t/no-space-left-on-boot/24019/11.
- Hypnix specific config structure re-writings. But since the hypnix configs also load the traditional NixOS config files (configuration.nix - which also loads hardware-configuration.nix) we keep high NixOS base compatiblilty.

## building

1. Git clone the [nixpkgs fork of hypnix](https://github.com/gernotfeichter/nixpkgs/tree/feat/hypnix).
2. In that fork, alter the [package.nix](../nixpkgs/pkgs/by-name/ca/calamares-hypnix-extensions/package.nix) to point to your changed version of the hpynix repository (not the fork).
   Change the version number(or you migth run into bad caching issues), in addition to the revision.
   Build the calamares-hypnix-extensions package: `nix-build -A pkgs.calamares-hypnix-extensions` (working dir: root of fork git repo!)
   After the first failed build you should read the new hash the hash! Enter the new hash into the package.nix and rebuild!
3. Build the iso: `nix-build -A config.system.build.isoImage -I nixos-config=modules/installer/cd-dvd/installation-cd-graphical-calamares-hypnix.nix` (working dir: nixos folder, one level below fork git repo root folder!)
   NOTE down the ISO_FILE_PATH, the line that contains it, looks like this: `Writing to 'stdio:/nix/store/1wg14npymm483vxz7xmyiszqd4fnzvcb-nixos-24.11pre-git-x86_64-linux.iso/iso/nixos-24.11pre-git-x86_64-linux.iso' completed successfully.`
4. Burn the image to a device (replace the DEVICE and ISO_FILE_PATH; e.g. I replace DEVICE by /dev/sdb, because this is my USB stick):
   `sudo dd bs=4M conv=fsync oflag=direct status=progress if=ISO_FILE_PATH of=DEVICE`