{pkgs,config,lib,archetype,...}:
let
cfg = config.desktop.display-managers.regreet;
in
{ 
  options.desktop.display-managers.regreet = {
    enable = lib.mkEnableOption "Enable regreet as the display manager.";
  };

  config = lib.mkIf cfg.enable {

    services.displayManager.sessionPackages = with pkgs; [
      niri
    ];

    programs.regreet = {
      enable = true;

      theme = {
        name = "Adwaita";
        package = pkgs.gnome-themes-extra;
      };

      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };

      font = {
        name = "Cantarell"; 
        package = pkgs.cantarell-fonts;
        size = 16;
      };
    };
  };

}
