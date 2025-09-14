#lib/modules/desktop-environment.nix
{config, lib, pkgs, inputs, ...}:
let
  cfg = config.desktop-environment;
  enabledList  = [ cfg.niri.enable cfg.hyprland.enable cfg.gnome.enable ];
  enabledCount = builtins.length (lib.filter (x: x) enabledList);
in
{
  options.desktop-environment = {
    enable = lib.mkEnableOption "Enable the usage of a desktop environment.";

    user = lib.mkOption {
      type = lib.types.str;
      default = "user";
      description = "Name of the user";
    };

    niri = {
      enable = lib.mkEnableOption "Enable niri as the desktop environment.";
    };

    hyprland = { 
      enable = lib.mkEnableOption "Enable niri as the desktop environment.";
    };

    gnome = {
      enable = lib.mkEnableOption "Enable niri as the desktop environment.";
    };

  };

  config = lib.mkMerge [
    {
      assertions = [
        {
          assertion = enabledCount == 1;
          message =
            "Exactly one of desktopEnvironment.{niri,hyprland,gnome}.enable must be true.";
        }
      ];
    }

    (lib.mkIf cfg.niri.enable {

      programs.niri.enable = true;
      hardware.graphics.enable = true;

      services.greetd.enable = true;
      services.greetd.settings = {
        default_session = {
          command = "niri-session"; 
          user = cfg.user;
        };
      }; 

      users.user.${cfg.user.userName} = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "ubridge" ];
        initialPassword = "changeme";
      };

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "backup";
      home-manager.users.${cfg.user.userName} = {
        programs.niri.config = ../../dotfiles/niri/config.kdl;
      };

    })

    (lib.mkIf cfg.hyprland.enable 
      (throw "Hyprland is not supported yet. This is a placeholder")
    )

    (lib.mkIf cfg.gnome.enable 
      (throw "Gnome is not supported yet. This is a placeholder")
    )
  ];
}
