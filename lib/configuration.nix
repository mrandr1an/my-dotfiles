#lib/configuration.nix
{lib,archetype,...}:
let
  inherit (lib) optionals;
  laptop = archetype.laptop or null;
  virtual-machine = archetype.virtual-machine or null;
  chrisl = archetype.laptop.user.userName or null;
  vmuser = archetype.virtual-machine.user.userName or null;
in
{
  imports =
    [
    ./modules/desktop-environment.nix
    ]
    ++ optionals (laptop != null) [./modules/laptop-hardware.nix ./modules/laptop-secrets.nix]
    ++ optionals (chrisl != null) [ ./modules/users/chrisl.nix]
    ++ optionals (vmuser != null) [];
  
  config = lib.mkMerge [

    (lib.mkIf (laptop != null) {
      desktop-environment.enable = true;

    })

    (lib.mkIf (virtual-machine != null) {

    })

    ];
}

