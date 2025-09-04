{
  description = "Compartmentalized secure NixOS configuration for homelabing and productivity.";

  inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
          url = "github:nix-community/home-manager/release-25.05";
	        inputs.nixpkgs.follows = "nixpkgs";
        };
	
 	      agenix = {
          url = "github:ryantm/agenix";
          inputs.nixpkgs.follows = "nixpkgs"; 
	      };
       
        flake-parts = {
 	        url = "github:hercules-ci/flake-parts";
	      };
  };

  outputs = inputs@{self,flake-parts,...}:
   flake-parts.lib.mkFlake { inherit inputs; } (top@{config,withSystem,moduleWithSystem,...}:
   {
     imports = [
       #Hosts
		   ./hosts/workstation
		   ./hosts/laptop
       #Devshells
       ./devshells/rust
       ./devshells/nix
    	       ];

     flake = {};

     systems = [ "x86_64-linux" ];

   });	
}
