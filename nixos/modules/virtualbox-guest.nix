{ config, lib, options, ... }:
{
  services.xserver.videoDrivers = lib.mkForce [
    "vmware"
    "virtualbox"
    "modesetting"
  ];

  # Remove the `fsck` that runs at startup. Will always fail on vbox
  boot.initrd.checkJournalingFS = false;

  systemd.user.services = let
  vbox-client = desc: flags: {
    description = "VirtualBox Guest: ${desc}";
    
    wantedBy = [ "graphical-session.target" ];
    requires = [ "dev-vboxguest.device" ];
    after = [ "dev-vboxguest.device" ];

    unitConfig.ConditionVirtualization = "oracle";
    serviceConfig.ExecStart = "@${config.boot.kernelPackages.virtualboxGuestAdditions}/bin/VBoxClient -fv ${flags}";
  };
  in {
    virtualbox-resize = vbox-client "Resize" "--vmsvga";
    virtualbox-clipboard = vbox-client "Clipboard" "--clipboard";
  };

  virtualisation.virtualbox = {
    guest = {
      enable = true;
      x11 = true;
    };
    #host = {
    #  enable = true;
    #  enableExtensionPack = true;
    #};
  };

  users.extraGroups.vboxusers.members = [ "ethane" ];
}
