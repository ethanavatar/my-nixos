{ inputs, lib, config, pkgs, ... }:
{  
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    gnumake
    pkg-config
    git
    vim
    home-manager

    networkmanagerapplet

    # For wayland
    kitty
    xdg-desktop-portal-gtk
    libnotify

    pavucontrol
    pipewire

    picom-jonaburg
    lua52Packages.luarocks
    lua52Packages.luadbi-mysql
    lua52Packages.lgi
  ];
}
