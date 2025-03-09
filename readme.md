# fork

> WIP: This is currently under development and not usable!

This folder contains this forked repo state: https://github.com/NixOS/calamares-nixos-extensions/releases/tag/0.3.19.

The code in this folder contains the calameres (nixos installation program - live installer) config and customizations for nixos and respective for hypnix on top of that.

Notable changes after forking:
- The original README was renamed to [README_original.md](README_original.md).
- Non-relevant desktop environments were removed from config files, not so from the code (should not hurt much), to reduce git conflict potential of this fork.
- The default size of the `/boot` partition was increased from `512MB` to `5GB` to avoid the common error `No space left on /boot` - https://discourse.nixos.org/t/no-space-left-on-boot/24019/11.
- Hypnix specific config re-writings.
