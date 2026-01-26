{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
  {
    self,
    nixpkgs,
    disko,
    nixos-hardware,
    home-manager,
    mango,
    dms,
    ...
  }:
  {
    nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        disko.nixosModules.disko
          nixos-hardware.nixosModules.framework-13-7040-amd
          home-manager.nixosModules.home-manager
          ./hosts/framework/hardware-configuration.nix
          ./hosts/framework/configuration.nix
          ./hosts/framework/disko-config.nix
          ./modules/packages.nix
          ./modules/unfree.nix
          mango.nixosModules.mango
          dms.nixosModules.dank-material-shell
          dms.nixosModules.greeter

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.rms = import ./home/rms.nix;
              backupFileExtension = "backup";
            };
          }
      ];
    };
  };
}
