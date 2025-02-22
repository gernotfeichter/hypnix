# hypnix

> open alpha

A [NixOS](https://nixos.org) based Linux distribution using a [Hyprland](https://hyprland.org) based desktop environment.

# features
- modern linux desktop (window animations)
- window auto-tiling (no screen waste per default!)
- desktop environment heavily shortcut based (vs traditional ones that are normally mouse based)
- no password typing required for standard actions (todo: docu since this is not active per default and it requires third party services to be configured correctly)
  - full disk decryption (through network based disk decryption)
  - terminal commands (more precisely PAM based commands, such as `sudo` etc.)

# config changes

```shell
# -E so that vi has access to the clipboard of the Hyprland session!
cd /etc/nixos && sudo -E su
# uses vi to edit config files (see config structure below)
v configuration.nix
# apply!
nixos-rebuild switch --impure
```

# config structure

- /etc/nixos/
  - `configuration-machine-specific.nix`: symlink to a specific machine config, per default there is only one machine config, so the symlink points to `hardware/default-machine-name/default.nix` (which imports further .nix files in this sub-tree)
  - `configuration.nix`: root config element, imports all other .nix files in the tree directly or indireclty (unless the user explicitly commented out/removed imports!)
  - `packages.nix`: list of user-level and system-level applications to install
  - `hardware/default-machine-name`: You can keep all your linux machine configs in one git repo, by having one folder per machine. Per default, there is only one machine called `default-machine-name`. Make sure the symlink `configuration-machine-specific.nix` points to the machine your are currently working on!
    - `clevis-luks.nix`: Can be used to configure passwordless boot (network bound disk decryption: TODO: further documentation)
    - `configuration.nix`: Original NixOS configuration.nix. Generally I would advise not editing this file if possible, but this is not a hard rule.
    - `default.nix`: Imports all other nix files that should be active for the given machine.
    - `hardware-configuration.nix`: Original NixOS hardware-configuration.nix. Generally I would advise not editing this file if possible, but this is not a hard rule.
    - `networking.nix`: Standard network config for a fully booted system. In case you want to modify the network config during the early boot phase (initrd), that goes preferentially into `clevis-luks.nix`.
    - `nvidia.nix`: Nvidia hacks. Even when not using nvidia, I would just keep it there if it does not make problems, but feel free to refactor it out if you don't use an nvidia graphics card.
    - `secrets`:
      - `luks.jwe`: Only required when using clevis (see `clevis.nix`). This file can be generated via the provided snippet, but requires a running tang server: `echo -n '<your luks passphrase>' | clevis encrypt tang '{"url": "http://<your tang server>:<your tang port>"}' > luks.jwe`
      - `wireless.env`: Generally only required when using clevis along with a WIFI based network connection (see `clevis.nix`). File content looks like: `WIFI_PASS=<ENTER_YOUR_PASSWORD_HERE>`. Another use case for this file would be, if instead of Networkmanager (default for hypnix), you prefer to use another network config mechanism, e.g. systemd-networkd, but even then to make use of this, you would need to explicitly honor this file by config snippets that you also find in `clevis.nix`.
  - `home`: Things managed by [home manager](https://github.com/nix-community/home-manager). This sub-tree docu is not a complete listing, check out the sub folders in /etc/nixos/home for the complete config!
    - `programs`
      - `hypr`: Hyprland config file, this includes monitor configuration!

# todos

- test screensharing/video conferencing
- document shortcuts
- document pills
  - setup unattended disk encryption via luks
  - setup passwordless pam via alp
- something like a ui to install packages, or better an entire sysconfig editor/ui AND therefore and easy and integrated way to apply/rollback those changes.
  Ideas: If existing language servers/IDEs provide a good enough base for this, maybe we can re-use that as basis, but this could get complex quickly.
  Maybe it's better to start with a primitive/narrowed down package install ui.
- cleanup/unify package installations, e.g. currently some packages are installed via home manager, some outside, which I don't like.

# building/releasing

This project can be built with:
```
earthly +all
```
The release command/process is to be documented, after all this is merely a note for the maintainer (currently the owner only).

# tribute

The basic nix code setup of running Hyprland on NixOS with HomeManager came from [HeinzDev](https://github.com/HeinzDev/Hyprland-dotfiles).
I transformed the original flake setup into the traditional NixOS module system, which I believe to be better suited for multi-platform support.
