{ config, lib, pkgs, boot, ... }:
let
  interfaceWifi = "wlp0s20u5";
  interfaceEth = "enp7s0";
  luksDeviceList = builtins.attrNames config.boot.initrd.luks.devices;
  luksDeviceIds = lib.lists.forEach luksDeviceList (x: lib.strings.removePrefix "luks-" x); 
  luksDeviceId = lib.lists.head luksDeviceIds;
  # code for generating allKernelModulesList - START
  filePathAllKernelModulePaths = "${config.system.modulesTree.outPath}/lib/modules/${config.boot.kernelPackages.kernel.version}/modules.order";
  fileAllKernelModulePaths = builtins.readFile filePathAllKernelModulePaths;
  kernelModulePathsSplitters = pkgs.lib.splitString "\n" fileAllKernelModulePaths;
  kernelModulePaths = builtins.filter (x: x != "") kernelModulePathsSplitters;
  allKernelModulesList = map (x: builtins.elemAt (pkgs.lib.match ".*/(.*)\.ko" x) 0) kernelModulePaths;
  # code for generating allKernelModulesList - END
in {
  # kernel modules allowed to be loaded in initrd boot phase (all)
  boot.initrd.availableKernelModules = allKernelModulesList;

  # dhcp
  networking.interfaces."${interfaceWifi}".useDHCP = true;
  networking.interfaces."${interfaceEth}".useDHCP = true;

  # initrd general
  boot.initrd.verbose = true;
  boot.initrd.enable = true;

  # networking
  boot.initrd.systemd.enable = true;
  boot.initrd.network.enable = true;
  boot.initrd.systemd.network.enable = true;
  boot.initrd.systemd.network.wait-online.enable = true;
  boot.initrd.systemd.emergencyAccess = true;
  boot.initrd.systemd.initrdBin = [ pkgs.wpa_supplicant pkgs.coreutils pkgs.systemd ];

  # clevis
  boot.initrd.clevis.enable = true;
  boot.initrd.clevis.useTang = true;
  boot.initrd.clevis.devices."luks-${luksDeviceId}".secretFile = secrets/luks.jwe;
  boot.initrd.systemd.users.root.shell = "/bin/systemd-tty-ask-password-agent";

  # wifi
  # https://discourse.nixos.org/t/wireless-connection-within-initrd/38317/13
  boot.initrd.systemd.packages = [ pkgs.wpa_supplicant ];
  boot.initrd.systemd.targets.initrd.wants = [ "wpa_supplicant@${interfaceWifi}.service" "systemd-resolved.service" ];
  boot.initrd.systemd.services."wpa_supplicant@".unitConfig.DefaultDependencies = false;
  boot.initrd.secrets."/etc/wpa_supplicant/wpa_supplicant-${interfaceWifi}.conf" = secrets/wpa_supplicant.conf;

  # ethernet
  boot.initrd.systemd.network.networks."10-wlan" = {
    matchConfig.Name = interfaceEth;
    networkConfig.DHCP = "yes";
  };

  # dns
  boot.initrd.services.resolved.enable = true;
}
