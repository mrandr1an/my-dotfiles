#hm/modules/niri.nix
{config, lib, pkgs, ...} :
let
  cfg = config.desktop-environment.window-manager.niri-config;
in
{
  options.desktop-environment.window-manager.niri-config = {
    enable = lib.mkEnableOption "Niri window manager with predefined config.";
    src = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.niri = {
      config = cfg.src;
    };
  };
}
