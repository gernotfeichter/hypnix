# fork

This folder contains this forked repo state: https://github.com/NixOS/calamares-nixos-extensions/releases/tag/0.3.19.

The code in this folder contains the calameres (nixos installation program - live installer) config and customizations for nixos and respective for hypnix on top of that.

Notable changes after forking:
- The original README was renamed to [README_from_fork.md](README_from_fork.md).
- Non-relevant desktop enivironments were removed.
- The default size of the `/boot` partition was increased from `512MB` to `5GB` to avoid the common error `No space left on /boot` - https://discourse.nixos.org/t/no-space-left-on-boot/24019/11.
- TODO: Hypnix specific config re-writing
