#lib/modules/system/home.nix
{config,lib,archetype,...}:
let
  cfg = config.syshome;
in
{
  options.syshome = {

    username = lib.mkOption {
      type = lib.types.str;
      default = "chrisl";
    };

    groups = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["wheel" "networkmanager" ];
    };

  };

  config = {  

    users.users."${cfg.username}" = {
      isNormalUser = true;
      hashedPasswordFile = config.age.secrets."${cfg.username}_password.path";
      extraGroups = cfg.groups;
    };
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users."${cfg.username}"=
    import "../../../hm/users/${cfg.username}.nix";
  home-manager.extraSpecialArgs = {
    desktop = archetype.desktop-environment;
  };
}
