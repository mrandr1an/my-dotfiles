{
  description = "My first flake";

  inputs = {
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
	
 	emacs-overlay = {
	 url = "github:nix-community/emacs-overlay/da2f552d133497abd434006e0cae996c0a282394";
	};

        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
	nixpkgs.overlays = [ (import self.inputs.emacs-overlay) ];
  };

  outputs = inputs@{self,flake-parts,...}:
   flake-parts.lib.mkFlake { inherit inputs; } (top@{config,withSystem,moduleWithSystem,...}:
   {
     imports = [
		./hosts/workstation
		./hosts/laptop
    	       ];

     flake = {};

     systems = [ "x86_64-linux" ];

     perSystem = {config,pkgs,inputs',self',system,...}: {
      devShells.nix = pkgs.mkShell {
          packages = [ 
		      inputs.agenix.packages.${system}.default 
		      pkgs.neovim
		      pkgs.git
 		      pkgs.libnotify
		     ];
	  shellHook = ''
		      echo "You are in NixOS dev mode"
	  	      '';
        };
     };
   });	
}
