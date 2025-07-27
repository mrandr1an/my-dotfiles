{config, pkgs, ...}:

{
   #Enable and configure the SDDM display manager
   services.displayManager.sddm.enable = true;  
   #Set Theme
   services.displayManager.sddm.theme = "breeze";  
}
