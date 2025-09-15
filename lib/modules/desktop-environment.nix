#lib/modules/desktop-environment.nix
{config, lib, pkgs, inputs, ...}:
let
  cfg = config.de;
in
{
  options.de = {
    niri.enable = lib.mkEnableOption "Niri enable.";
    userName = lib.mkOption { type = lib.types.str; };
    userPwd = lib.mkOption { type = lib.types.str; };
  };

  config = lib.mkIf cfg.niri.enable {  
    users.users.${cfg.userName} = {
        isNormalUser = true;
        description = "The test user";
        initialPassword = cfg.userPwd;
    };

    programs.niri.enable = true; 
    hardware.graphics.enable = true;

    services.greetd.enable = true;
    services.greetd.settings = {
      default_session = {
        command = "niri-session";  
        user = "chrisl";
      };
    };
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.backupFileExtension = "backup";
  };
}
