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
    inputs.disko.nixosModules.disko
    (import ../disko/laptop-btrfs-encrypted.nix {
          hdd = { name = "/dev/sdb"; };
          ssd = { name = "/dev/sda"; };
     })
    ./configuration.nix
  ];
}
