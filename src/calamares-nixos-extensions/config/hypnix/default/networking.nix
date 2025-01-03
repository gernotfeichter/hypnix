{ config, ... }:
{
  # networking with networkmanager
  networking.networkmanager.enable = true;

  # networking with networkd example config snippets
  # networking.useNetworkd = true;
  # networking.wireless.enable = true;
  # networking.wireless.secretsFile = secrets/wireless.env;
  # networking.wireless.networks."A1-D1558472".pskRaw = "ext:WIFI_PASS";
  # networking.wireless.networks."Pixel-5".pskRaw = "ext:WIFI_PASS";
  # networking.wireless.networks."Pixel-5".priority = 1000;
}
