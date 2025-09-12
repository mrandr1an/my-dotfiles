#lib/mkSystem.nix
{inputs}:
{arch ? "x86_64-linux", hostname}:
inputs.nixpkgs.lib.nixosSystem {
  system = arch;
  specialArgs = { inherit inputs hostname; };
  modules = [
   ../hosts/invincible/configuration.nix
    inputs.niri-flake.nixosModules.niri
    inputs.agenix.nixosModules.age
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "backup";
      home-manager.users.chrisl =
        import ../hosts/common/users/chrisl-home.nix;
    } 
  ];
}
