{ config, lib, pkgs, ... }:

{
  options.hypnix = {
    standardUser = lib.mkOption {
      type = lib.types.str;
      description = ''
        The standard user name (not root) of the nixos multi-user installation.
      '';
      default = false;
    };
  };

}