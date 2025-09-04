{config,pkgs,...} :
{
  imports =
    [
      ./network.nix
      ./locale.nix
      ./users.nix
      ./secrets.nix
      ./system.nix
      ./network.nix
      ./packages.nix
    ];
}
