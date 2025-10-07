{config,lib,...}:
let
  cfg = config.desktop-environment;
in
{
  imports =
    [
     ./window-managers
    ];

  options.desktop-environment = {
    enable = lib.mkEnableOption "Enable desktop-environment.";
  };

  config = lib.mkIf cfg.enable {
    desktop-environment.window-managers.enable = true;
  };
}
