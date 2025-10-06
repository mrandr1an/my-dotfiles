#hm/modules/niri.nix
{config, lib, pkgs, ...} :
let
  cfg = config.desktop-environment.window-manager.niri;
in
{
  options.desktop-environment.window-manager.niri = {
    enable = lib.mkEnableOption "Enable Niri window manager."; 
  };

  config = lib.mkIf cfg.enable {
    programs.niri = {
      enable = true;
    };
  };
}
