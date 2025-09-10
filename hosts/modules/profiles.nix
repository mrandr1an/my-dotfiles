# hosts/modules/profiles.nix
{pkgs, nixpkgs, system}:
let
 lib = nixpkgs.lib; 

 mkBase = {hostname, modules}:
     lib.nixosSystem {
       inherit system;
       modules =
         [
          ({ ... }: { networking.hostName = hostname; })
         ] ++ modules;
     };

 desktop = { hostname, modules } :
   mkBase {
     inherit hostname modules; 
   };
in
{
  hostType = {
    inherit desktop;
  };
}
