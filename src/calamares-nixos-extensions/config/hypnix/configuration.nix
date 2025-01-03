{ config, lib, pkgs, ... }:

{

  imports = [
    ./home/default.nix
    ./confiugration-machine-specific.nix
    ./packages.nix
  ];

  options.hypnix = {
    standardUser = mkOption {
      type = types.str;
      description = ''
        The standard user name (not root) of the nixos multi-user installation.
      '';
      default = false;
    };
  };

  config = {
    hypnix.standardUser = "nix";
  };

}