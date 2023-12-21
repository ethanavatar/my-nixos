{ inputs, lib, config, pkgs, ... }:
{
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };
  programs.dconf.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
  
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager = {
      defaultSession = "none+awesome";
      gdm.enable = true;
    };
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.lua52Packages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
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
  security = {
    pam.services.swaylock = {
      fprintAuth = false;
      text = ''
        auth include login
      '';
    };
  };

  services.dbus.enable = true;
  xdg = {
    autostart.enable = true;
    portal = { 
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ]; 
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Enable automatic login for the user.
  # TODO: Turn this module into a function that takes a user name.
  #services.xserver.displayManager.autoLogin.enable = true;
  #services.xserver.displayManager.autoLogin.user = "ethane";
}
