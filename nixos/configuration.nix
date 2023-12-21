{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    ./modules/locale.nix
    ./modules/virtualbox-guest.nix

    ./modules/system-packages.nix

    ./modules/xserver.nix
    ./modules/audio.nix
  ];

  system.stateVersion = "23.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  # Keeping a POSIX shell as the default.
  # Any non-standard ones should be configured in home-manager.
  users.defaultUserShell = pkgs.zsh;
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  users.users.ethane = {
    isNormalUser = true;
    description = "Ethan Evans";

    # TODO: Real secret management
    initialPassword = "password";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
