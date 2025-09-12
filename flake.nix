{
  description = "Compartmentalized secure NixOS configuration for homelabing and productivity.";

  inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
          url = "github:nix-community/home-manager/master";
	        inputs.nixpkgs.follows = "nixpkgs";
        };

	      disko = {
          url   = "github:nix-community/disko";
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
      let
        mkSystem = import ./lib/mkSystem.nix { inherit inputs; };
      in
   {
     imports = [
       # flake-parts' Home Manager module (exposes flake.homeConfigurations, etc.)
       inputs.home-manager.flakeModules.home-manager
       #Hosts
		   ./hosts/invincible
		   ./hosts/syncthingVM
       #Devshells
       ./devshells/rust.nix
       ./devshells/nix.nix
    	       ];

     flake = {};
     
     systems = [ "x86_64-linux" ];
     
   });	
}
