#lib/mkSystem.nix
{inputs}:
{archetype}:
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
    (import ./mkDisko {
      archetype = archetype;
     })
    ./configuration.nix
  ];
}
