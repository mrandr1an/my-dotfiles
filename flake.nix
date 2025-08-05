{
  description = "My first flake";

  inputs = {
        nixpkgs = {
	  url = "nixpkgs/nixos-25.05";
        };
        
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
		     ];
	  shellHook = ''
		      echo "You are in NixOS dev mode"
	  	      '';
        };
     };
   });	
}
