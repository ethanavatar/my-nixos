{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    
    ## Things to consider
    # lanzaboote
    # nixos-hardware
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    disko,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake ~/.nixos#nixos'
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        #system = "x86_64-linux";
        specialArgs = { inherit inputs outputs; };
        modules = [ ./nixos/configuration.nix ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake ~/.nixos#ethane@nixos'
    homeConfigurations = {
      "ethane@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [ ./home-manager/home.nix ];
      };
    };
  };
}
