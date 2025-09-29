#lib/configuration.nix
{lib,archetype,...}:
let
  inherit (lib) optionals;
  workstation = archetype.workstation;
  virtual-machine = archetype.virtual-machine;
in
{
  
}
