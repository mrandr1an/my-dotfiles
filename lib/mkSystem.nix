#lib/mkSystem.nix
{inputs}:
{archetype}:
inputs.nixpkgs.lib.nixosSystem {
  system = archetype.system.arch;
  specialArgs = { inherit inputs archetype; };
  modules = [
    ./configuration.nix
    inputs.niri-flake.nixosModules.niri
    inputs.agenix.nixosModules.age
    inputs.home-manager.nixosModules.home-manager
  ];
}
