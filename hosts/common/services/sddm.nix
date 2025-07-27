{config, pkgs, ...}:
let
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
   #Enable and configure the SDDM display manager
   services.displayManager.sddm.enable = true;  
   services.displayManager.sddm.theme = "sddm-astronaut-theme";
   services.displayManager.sddm.package = pkgs.kdePackages.sddm;
   services.displayManager.sddm.wayland.enable = true; 
   services.displayManager.sddm.enableHidpi = true;
   services.displayManager.sddm.extraPackages = [sddm-astronaut]; 
   
   environment.systemPackages = [
             sddm-astronaut
             pkgs.kdePackages.qtmultimedia
            ];
}
