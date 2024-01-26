{ inputs, lib, config, pkgs, ... }:
{  
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  environment.systemPackages = with pkgs; [
    wget
    gnumake
    pkg-config
    git
    vim
    home-manager

    networkmanagerapplet
    pavucontrol
    pipewire

    ## Widow Manager stuff
    lua52Packages.luarocks
    lua52Packages.luadbi-mysql
    lua52Packages.lgi
    # a fork of picom with rounded corners and animations
    picom-jonaburg
  ];
}
