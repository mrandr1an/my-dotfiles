{ config, pkgs, ... }:
 let
  sddmService = import ../common/services/sddm.nix;
  niriService = import ../common/services/niri.nix;
  emacsService = import ../common/services/emacs.nix;
  bitwardenService = import ../common/services/bitwarden.nix;
  waybarService = import ../common/services/waybar.nix;
 in
{
  imports =
    [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include Common Services
      sddmService
      niriService
      bitwardenService
      waybarService
      emacsService
      # Include Host Specific Services
      ./network.nix
      ./locale.nix
      ./users.nix
      ./system.nix
      ./packages.nix
      ./secrets.nix
    ]; 
}
