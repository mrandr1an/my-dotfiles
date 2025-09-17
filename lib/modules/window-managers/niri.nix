#lib/modules/window-managers/niri.nix
{config,lib,archetype}:
let
  cfg = config.desktop.window-managers.niri;
in
{
  imports = [
    ../display-managers/regreet.nix
    ../display-managers/sddm.nix
  ];

  options.desktop.window-manager.niri = {
    enable = lib.mkEnableOption "Enable Niri as the window manager.";
 
    displayManager = lib.mkOption {
      type = lib.types.submodule {
        options = {
          theme = lib.mkOption {
            type = lib.types.str;
            default = "default";
            example = "default";
          };
          program = lib.mkOption {
            type = lib.types.enum ["ssdm" "regreet"];
            default = "regreet";
            example = "regreet";
          };
        };
      };
    };

    statusBar = lib.mkOption {
      type = lib.types.enum ["waybar"];
      example = "waybar";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [

    (lib.mkIf (cfg.displayManager.program == "sddm"){
      desktop.display-managers.sddm.enable = true;
    })

    (lib.mkIf (cfg.displayManager.program == "regreet"){
      desktop.display-managers.regreet.enable = true;
    })
  ]);
}
