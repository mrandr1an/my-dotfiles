#lib/mkSystem.nix
{inputs}:
{archetype}:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86-64-linux";
  specialArgs = { inherit inputs archetype; };
  modules = [
    inputs.niri-flake.nixosModules.niri
    inputs.agenix.nixosModules.age
    inputs.home-manager.nixosModules.home-manager
    ./configuration.nix
  ];
}
