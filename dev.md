# source code

The source code of hypnix is maintained on the following fork of nixpkgs:
https://github.com/gernotfeichter/nixpkgs/tree/feat/hypnix

# building and testing

1. `gh repo clone gernotfeichter/nixpkgs`
2. `cd nixpkgs`
3. `git checkout feat/hypnix`
4. `cd nixos`
5. `nix-build -A config.system.build.isoImage -I nixos-config=modules/installer/cd-dvd/installation-cd-graphical-hypnix.nix`. NOTE down the ISO_FILE_PATH, the line that contains it, looks like this: Writing to 'stdio:/nix/store/1wg14npymm483vxz7xmyiszqd4fnzvcb-nixos-25.11pre-git-x86_64-linux.iso/iso/nixos-25.11pre-git-x86_64-linux.iso' completed successfully.
6. `sudo dd if=<ISO_FILE_PATH_FROM_PREVIOUS_STEP> of=/dev/sdX` (burns the image, e.g. to a USB stick, REPLACE the device sdX with your actual device, e.g. I normally run lsblk to figure out my storage device names). Running this command can take long.
7. Boot from your newly flashed device and test the live system. Things to watch out for:
    - The installer should start automatically.
    - The installer part of the keyboard selection should ideally be (also) tested for a non-us keyboard layout.
    - The installer should install the system to your hard drive. I typically select the "Erase disk" option and use swap + hibernate along with full disk encryption. Not only to cover the most common use-case but also because I would recommend those settings.
    - Testing the installed system: Open terminal, browser, move windows, switch focus etc.

# releases

1. Releases also go through the [building and testing](#building-and-testing) phase.
2. A git tag is created with the next version number. The version numbers follow the SemVer scheme.
3. The iso file is uploaded to https://drive.google.com/drive/folders/1HDrhGZFeXwFT8lUaF6di-TJMUIaO02Bo and renamed to follow the existing naming pattern. Releases can currently only be performed by the owner.