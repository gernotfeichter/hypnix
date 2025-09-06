{ config, lib, pkgs, ... }:
{
    sddm = {
      enable = true;
      wayland.enable = true;
    };
}