{inputs,lib,...}:
{
 flake.nixosConfigurations.syncthingVM = inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
      ./configuration.nix
      inputs.agenix.nixosModules.age
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.vmuser = import ../common/users/vmuser-home.nix;
      }
    ];
  };
}
