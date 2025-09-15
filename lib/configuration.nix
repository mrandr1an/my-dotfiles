#lib/configuration.nix
{lib,archetype,...}:
let
  inherit (lib) optionals;
  laptop = archetype.laptop or null;
in
{
  imports =
    [
    ./modules/desktop-environment.nix
    ./modules/locale.nix
    ] ++ optionals (laptop != null) [./modules/laptop-hardware.nix] ;
  
  config = lib.mkMerge [
    (lib.mkIf (laptop != null) {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      system.stateVersion = "25.05";
      nix.settings.experimental-features = [ "nix-command" "flakes" ];

      networking.hostName = laptop.system.hostname;

      de =
        let
          userName' = laptop.desktop.user.userName;
          userPwd' = laptop.desktop.user.userPwd;
        in
          {
            userName = userName';
            userPwd = userPwd';
            niri.enable = true;
          };

      locale =
        let
          timeZone' = laptop.system.locale.timeZone;
        in
          {
            timeZone = timeZone';
          };
    })
    ];
}

