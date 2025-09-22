#lib/mkSystem.nix
{inputs}:
{archetype}:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86-64-linux";
  specialArgs = { inherit inputs archetype; };
  modules = [
    inputs.disko.nixosModules.disko
    inputs.agenix.nixosModules.age
    inputs.home-manager.nixosModules.home-manager
    { home-manager.sharedModules = [ inputs.niri-flake.homeModules.niri ]; }
    (import ../disko/laptop-btrfs-encrypted.nix {
          hdd = { name = "/dev/sdb"; };
          ssd = { name = "/dev/sda"; };
     })
    ./configuration.nix
  ];
}
