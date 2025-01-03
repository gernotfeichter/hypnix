{ hyprland, pkgs, ...}: {

  imports = [
    #hyprland.homeManagerModules.default
    ./programs
    ./scripts
    ./themes
  ];

  home = {
    username = "nix";
    homeDirectory = "/home/nix";
  };

  home.packages = (with pkgs; [
    
    #User Apps
    celluloid
    librewolf
    cool-retro-term
    bibata-cursors
    lollypop
    lutris
    openrgb

    #utils
    ranger
    wlr-randr
    git
    rustup
    gnumake
    catimg
    curl
    appimage-run
    xflux
    dunst
    pavucontrol
    sqlite
    waypaper

    #misc 
    cava
    nano
    nitch
    wget
    grim
    slurp
    wl-clipboard
    pamixer
    mpc-cli
    tty-clock
    eza
    btop
    tokyo-night-gtk
    dconf
    pipewire
    waypaper
    nautilus
    zenity
    gnome-tweaks
    eog
  ]);
  
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-B-LB";
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
}
