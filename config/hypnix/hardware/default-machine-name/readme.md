# hardware-specific folder

This folder is for hardware/machine specific settings.

The default name of this very folder is "default-machine-name", be free to rename it, knowing that you also have to update the symlink `configuration-machine-specific.nix` in such a case to point to .

By using one folder per hardware/machine, we can achieve
- a basic config that should be available on all machines (that is in the parent of the machine-specific folders).
- 