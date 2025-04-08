{ config, lib, pkgs, ... }:

{

  imports = [
    ./home/default.nix
    ./configuration-machine-specific.nix
    ./packages.nix
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