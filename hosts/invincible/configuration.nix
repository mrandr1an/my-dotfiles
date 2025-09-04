{config,pkgs,...} :
{
  imports =
    [
      ./hardware-configuration.nix
      ./network.nix
      ./locale.nix
      ./users.nix
      ./secrets.nix
      ./system.nix
      ./network.nix
      ./packages.nix
    ];
}
