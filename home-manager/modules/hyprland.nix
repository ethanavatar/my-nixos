{config, pkgs, ...}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
    monitor=DP-1,1920x1080@60,0x0,1
    '';
  };
}
