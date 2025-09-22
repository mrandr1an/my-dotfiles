#hm/modules/niri.nix
{config, lib, pkgs, ...} :
let
  cfg = config.desktop-environment.window-manager.niri;
in
{
  options.desktop-environment.window-manager.niri = {
    enable = lib.mkEnableOption "Niri window manager with predefined config.";
    src = lib.mkOption {
      type = lib.types.str;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.niri = {
      enable = true;
      config = cfg.src;
    };
  };
}
