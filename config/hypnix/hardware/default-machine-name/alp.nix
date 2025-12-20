{ config, lib, pkgs, boot, ... }:
{
  services.pam.alp = {
    enable = false;
    keyFile = secrets/alp.key;
    targets = [ "_gatway:7654" ]; # when your android phone is your Hotspot and running alp pick this
    # targets = [ "10.0.0.195:7654" ]; # otherwise you must provide the IP of your android phone
  }
}