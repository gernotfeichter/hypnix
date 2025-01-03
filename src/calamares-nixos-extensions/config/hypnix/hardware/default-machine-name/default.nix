{ config, ... }:

{

  imports = [
    ./clevis-luks.nix
    ./configuration.nix # imports hardware-configuration.nix (default nixos config files are untouched by hypnix!)
    ./networking.nix
    ./nvidia.nix
  ];

}