{
  description = "My first flake";

  inputs = {
	nixpkgs.url = "nixpkgs/nixos-25.05";
        home-manager.url = "github:nix-community/home-manager/release-25.05";
	home-manager.inputs.nixpkgs.follows = "nixpkgs";
        agenix.url = "github:ryantm/agenix";
        agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self,nixpkgs,home-manager,agenix,...}:
   let
     system = "x86_64-linux";
     lib = nixpkgs.lib;
     pkgs = import nixpkgs {
            inherit system;
	    config.allowUnfree = true;
     };
   in {
    nixosConfigurations = {
	 workstation = lib.nixosSystem {
         inherit pkgs system;
	 modules = [
 		     ./hosts/workstation/configuration.nix
                     agenix.nixosModules.age
                     home-manager.nixosModules.home-manager
                     {
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.backupFileExtension = "backup";
			home-manager.users.chrisl = import ./hosts/workstation/users/chrisl-home.nix;
                     }
		   ];
       };
    };

   devShells.x86_64-linux.default = pkgs.mkShell {
      packages = [
        agenix.packages.x86_64-linux.default
      ];
    };
  };
}
