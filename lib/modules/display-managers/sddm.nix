#lib/modules/display-managers/sddm.nix
{config,lib,pkgs}:
let
  cfg = config.desktop.display-managers.sddm;
  sddm-astronaut = pkgs.sddm-astronaut.override {
      themeConfig = {
       AccentColor = "#746385";
       FormPosition = "left";
       ForceHideCompletePassword = true; 
      }; 
      embeddedTheme = "japanese_aesthetic";
   };
in
{
  options.desktop.display-managers.sddm = {
    enable = lib.mkEnableOption "Enable SDDM as the display manager.";
    theme = lib.mkOption {
      type = lib.types.str;
      default = "sddm-atronaut-theme";
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.theme = cfg.theme;
    services.displayManager.sddm.package = pkgs.kdePackages.sddm;
    services.displayManager.sddm.wayland.enable = true; 
    services.displayManager.sddm.enableHidpi = true;
    services.displayManager.sddm.extraPackages = [sddm-astronaut];

    environment.systemPackages = [
      sddm-astronaut
      pkgs.kdePackages.qtmultimedia
    ];
  };
}
