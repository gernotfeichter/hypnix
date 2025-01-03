{ config, lib, pkgs, ... }:
{
  users.users."${config.hypnix.standardUser}".packages = with pkgs; [
      firefox
      neofetch
      lolcat
      kate
      google-chrome
      libreoffice-qt
      go
      flutter
      kubectl
      kubernetes-helm
      goreleaser
      vscode
      vlc
      wev
      ripgrep
      gdb
      playerctl
      gnome-multi-writer
      wlsunset
      gimp
      hyprshot
      android-studio
      android-tools
      sdkmanager
      nmap
      jdk21
      bundletool
      python3
   ];

  environment.systemPackages = with pkgs; [
    networkmanager
    wget
    clevis
    git
    gh
    kitty
    wl-clipboard
    gparted
    alp
    dig
    binwalk
    killall
    brightnessctl
    usbutils
    unzip
    cmake
    meson
    cpio
  ];

}
