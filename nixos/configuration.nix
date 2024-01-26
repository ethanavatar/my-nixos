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

  # Zen Kernel is very good but i've already had boot issues with it.
  # So Im sticking with stable for now.
  boot = {
    #boot.kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = pkgs.linuxPackages_zen;
  };

  ## Bootloader.
  # TODO: Figure out how to generalize this for other systems.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  # Keep POSIX shell as the user default.
  users.defaultUserShell = pkgs.zsh;
  users.users.ethane = {
    isNormalUser = true;
    description = "Ethan Evans";
    shell = pkgs.nushell;

    # TODO: Real secret management
    initialPassword = "password";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
}
