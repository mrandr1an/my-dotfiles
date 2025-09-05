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

        niri-flake = {
          url = "github:sodiboo/niri-flake";
          inputs.nixpkgs.follows = "nixpkgs"; 
        };

        emacs-overlay = {
          url = "github:nix-community/emacs-overlay";
        };
  };

  outputs = inputs@{self,flake-parts,...}:
   flake-parts.lib.mkFlake { inherit inputs; } (top@{config,withSystem,moduleWithSystem,...}:
   {
     imports = [
       # flake-parts' Home Manager module (exposes flake.homeConfigurations, etc.)
       inputs.home-manager.flakeModules.home-manager
       #Hosts
		   ./hosts/workstation
		   ./hosts/laptop
		   ./hosts/invincible
       #Devshells
       ./devshells/rust.nix
       ./devshells/nix.nix
    	       ];

     flake = {};

     systems = [ "x86_64-linux" ];
     
   });	
}
