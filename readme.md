# hypnix

> open alpha

A [NixOS](https://nixos.org) based Linux distribution using a [Hyprland](https://hyprland.org) based desktop environment.

# todos

- test screensharing/video conferencing
- document pills
  - setup unattended disk encryption via luks
  - setup passwordless pam via alp
- something like a ui to install packages, or better an entire sysconfig editor/ui AND therefore and easy and integrated way to apply/rollback those changes.
  Ideas: If existing language servers/IDEs provide a good enough base for this, maybe we can re-use that as basis, but this could get complex quickly.
  Maybe it's better to start with a primitive/narrowed down package install ui.
- cleanup/unify package installations, e.g. currently some packages are installed via home manager, some outside, which I don't like.
