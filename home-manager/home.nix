{ inputs, lib, config, pkgs, ...}:
{
  imports = [ ];

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.stateVersion = "23.11";

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home = {
    username = "ethane";
    homeDirectory = "/home/ethane";
  };
 
  home.packages = with pkgs; [
    firefox
    wezterm
    nushell
    bat
    gh
    neofetch
    zoxide
    starship

    # Node is needed for github copilot
    nodejs_21
    zig
  ];

  gtk.enable = true;
  programs.neovim.enable = true;
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName  = "Ethan Evans";
    userEmail = "ethanalexevans@gmail.com";
  };
}
