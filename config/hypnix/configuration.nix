{ config, lib, pkgs, ... }:

{

  imports = [
    ./home/default.nix
    ./hardware.nix
    ./configuration-machine-specific.nix
    ./packages-system.nix
    ./packages-user.nix
    ./programs.nix
    ./displaymanager.nix
  ];

  options.hypnix = {
    standardUser = lib.mkOption {
      type = lib.types.str;
      description = ''
        The standard user name (not root) of the nixos multi-user installation.
      '';
      default = false;
    };
  };

  config = {
    hypnix.standardUser = "@@username@@";
  };

}