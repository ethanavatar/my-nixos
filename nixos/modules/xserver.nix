{ inputs, lib, config, pkgs, ... }:
{
  hardware = {
    opengl.enable = true;
    # Fixes invisible cursor on Nvidia GPUs
    nvidia.modesetting.enable = true;
  };

  programs.dconf.enable = true;
  services.dbus.enable = true;

  # Required for gdm to launch
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services.xserver = {
    enable = true;
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;

    layout = "us";
    xkbVariant = "";

    displayManager = {
      defaultSession = "none+awesome";
      gdm.enable = true;

      # TODO: Turn this module into a function that takes a user name.
      autoLogin = {
        enable = true;
        user = "ethane";
      };
    };

    windowManager.awesome = {
      enable = true;
      # awesome 4.3 uses lua 5.2
      luaModules = with pkgs.lua52Packages; [
        luarocks
        luadbi-mysql
        lgi
      ];
    };
  };

  security.polkit.enable = true;
  systemd = {
  user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
