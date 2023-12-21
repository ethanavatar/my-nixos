{ inputs, lib, config, pkgs, ... }:
{  
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    wget
    git
    vim
    home-manager

    networkmanagerapplet

    # For wayland
    hyprland
    kitty
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    waybar
    dunst
    libnotify
    hyprpaper
    rofi-wayland
    meson
    wayland-protocols
    wayland-utils
    wl-clipboard
    wlroots

    pavucontrol
    pipewire

  ];
}
