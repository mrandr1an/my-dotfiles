{inputs,lib,...}:
{
 flake.nixosConfigurations.invincible = inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
      ./configuration.nix
      inputs.agenix.nixosModules.age
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.vmuser = import ../common/users/chrisl-home.nix;
      }
    ];
  };
}
