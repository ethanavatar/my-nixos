{ inputs, lib, config, pkgs, ... }:
{  
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  # TODO: Use clang globally to replace gcc
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

    ## Window Manager stuff
    lua52Packages.luarocks
    lua52Packages.luadbi-mysql
    lua52Packages.lgi

    # A fork of picom with rounded corners and animations
    picom-jonaburg

    # A fallback terminal in-case the configured one is broken 
    kitty
  ];
}
