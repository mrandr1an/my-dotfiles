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
  };

  outputs = inputs@{self,flake-parts,emacs-overlay, ...}:
   flake-parts.lib.mkFlake { inherit inputs; } (top@{config,withSystem,moduleWithSystem,...}:
   {
     imports = [
		 inputs.flake-parts.flakeModules.nixpkgs
		./hosts/workstation
		./hosts/laptop
    	       ];

     flake = {};
     
     nixpkgs = {
      overlays = [ inputs.emacs-overlay.overlays.default ];
     };

     systems = [ "x86_64-linux" ];

     perSystem = {config,pkgs,inputs',self',system,...}: {

  	_module.args.pkgs = import inputs.nixpkgs {
    	  inherit system;
    	    overlays = [
    		         inputs.emacs-overlay.overlay
		       ]; 
	};

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
