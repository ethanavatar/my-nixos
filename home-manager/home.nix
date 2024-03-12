{ inputs, lib, config, pkgs, ...}:
let
  sessionVariables = {
    BROWSER = "firefox";
    MOZ_USE_XINPUT2 = "1";
  };
in
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
    wezterm
    bat
    gh
    neofetch
    zoxide
    starship

    # Node is needed for github copilot
    nodejs_21
    zig
  ];

  home.sessionVariables = sessionVariables;
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      }; 
      DisablePocket = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DisplayBookmarksToolbar = "always";
      DisplayMenuBar = "default-off";
      SearchBar = "unified";
    };
  };

  programs.nushell = {
    enable = true;
    # TODO: Overlay the latest version
    package = pkgs.nushell;
    #environmentVariables = sessionVariables;
  };

  gtk.enable = true;
  programs.neovim.enable = true;
  programs.home-manager = {
    enable = true;
  };
  programs.git = {
    enable = true;
    userName  = "Ethan Evans";
    userEmail = "ethanalexevans@gmail.com";
  };
}
