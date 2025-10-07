#hm/modules/niri.nix
{config, lib, pkgs, ...} :
let
  cfg = config.desktop-environment.window-managers.niri;
in
{
  options.desktop-environment.window-managers.niri = {
    enable = lib.mkEnableOption "Enable Niri window manager."; 
  };

  config = lib.mkIf cfg.enable {

    programs.niri = {
      enable = true;
    };
  };
}
