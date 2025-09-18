#lib/modules/desktop-environment.nix
{config, lib, ...}:
let
  cfg = config.desktop-environment;
in
{
  imports = [
    ./window-managers/niri.nix
  ];

  options.desktop-environment = {
    enable = lib.mkEnableOption "Enable Desktop.";
    
    window-manager = lib.mkOption {
      type = lib.types.enum ["niri"]; 
      default = "niri";
      example = "niri";
    }; 
  };

  config = lib.mkIf cfg.enable (lib.mkMerge[
    (lib.mkIf (cfg.window-manager == "niri"){
      desktop.window-managers.niri.enable = true;
    })
  ]);

}
