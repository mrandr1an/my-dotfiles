#lib/mkSystem.nix
{inputs}:
{host}:
let
  scanSchema = import ./scanSchema.nix;
  mkDisko =
    let
      mkDisko1 = import ./mkDisko.nix {archetype = archetype;};
      mkDisko2 = mkDisko1 {lib = inputs.nixpkgs.lib;};
    in
      mkDisko2; 
  archetype = scanSchema {hostName = host;};
in
inputs.nixpkgs.lib.nixosSystem {
  system = archetype.arch;
  specialArgs = { inherit inputs archetype; };
  modules = [
    inputs.disko.nixosModules.disko
    inputs.agenix.nixosModules.age
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.sharedModules = [
        inputs.niri-flake.homeModules.niri
      ];
    }
    (mkDisko)
    ./configuration.nix
  ];
}
