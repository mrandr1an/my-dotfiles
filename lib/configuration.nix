#lib/configuration.nix
{lib,inputs,pkgs,archetype,...}:
let
  inherit (lib) optionals;
  laptop = archetype.laptop or null;
  virtual-machine = archetype.virtual-machine or null;
in
{
  imports =
    [
    ./modules/desktop-environment.nix
    ./modules/locale.nix
    ] ++ optionals (laptop != null) [./modules/laptop-hardware.nix] ;

  config = lib.mkMerge [
    (lib.mkIf (laptop != null)) {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      networking.hostName = "testhostname";
      system.stateVersion = "25.05";

      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      desktop-environment = {
        enable = true;
        user = archetype.user;
        niri.enable = archetype.desktop-environment.niri.enable;
      };

      locale = {
        timeZone = archetype.locale.timeZone;
      };
      
    }

    (lib.mkIf (virtual-machine != null)) {
      
    }
    ];
}

