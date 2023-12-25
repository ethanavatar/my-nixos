# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, lib, config, pkgs, ...}:
{
  imports = [
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "ethane";
    homeDirectory = "/home/ethane";
  };
 
  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [
    firefox
    wezterm
    nushell
    gh
    neofetch

    nodejs_21
    zig_0_10
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";

  gtk.enable = true;

  programs.neovim.enable = true;

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName  = "Ethan Evans";
    userEmail = "ethanalexevans@gmail.com";
  };
}
