{ inputs, outputs, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ]; 

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      ethane = import ../home-manager/home.nix;
    };
  };

  environment.systemPackages = [
    inputs.home-manager.packages.${pkgs.system}.default
  ];
}
