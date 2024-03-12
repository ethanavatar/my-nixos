{ inputs, lib, config, pkgs, ...}: {
  home.packages = with pkgs; [
    discord
  ];
  nixpkgs.overlays = [
    (self: super: {
      discord = super.discord.overrideAttrs (_: {
        src = builtins.fetchTarball {
          url = "https://discord.com/api/download?platform=linux&format=tar.gz";
          sha256 = "1qli8gr2i4bab8qf9izswx4i7490l0bkpk19ny8nv2h2fci25f6m";
        };
      });
    })
  ];
}
