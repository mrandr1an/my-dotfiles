{config,lib,...}:
let
  cfg = config
    .desktop-environment
    .window-managers;
in
{
  imports =
    [
      ./niri.nix
      ./status-bars/waybar.nix
    ];

  options.desktop-environment.window-managers = {
    enable = lib.mkEnableOption "Enable window managers.";
  };

  config = lib.mkIf cfg.enable {
    desktop-environment.
      window-managers = {
      niri.enable = true;
      status-bar.enable = true;
    };
  };
}
