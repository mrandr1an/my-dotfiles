{
  description = "My first flake";
  
  inputs = {
	nixpkgs.url = "nixpkgs/nixos-25.05";
        home-manager.url = "github:nix-community/home-manager/release-25.05";
	home-manager.inputs.nixpkgs.follows = "nixpkgs";      
        agenix.url = "github:ryantm/agenix";
  };

  outputs = {self,nixpkgs,home-manager,agenix,...}:
   let 
     system = "x86_64-linux";
     pkgs = import nixpkgs {inherit system;};
     lib = nixpkgs.lib;
   in {
    nixosConfigurations = {
	 workstation = lib.nixosSystem {
	 system = "x86_64-linux";
	 modules = [ 
 		     ./hosts/workstation/configuration.nix 
                     agenix.nixosModules.default
                     home-manager.nixosModules.home-manager
                     {
                        age.secrets = import ./secrets/secrets.nix;
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.backupFileExtension = "backup";
			home-manager.users.chrisl = import ./hosts/workstation/users/chrisl-home.nix;
                     }
		   ];  
       };
    };
  };

}
