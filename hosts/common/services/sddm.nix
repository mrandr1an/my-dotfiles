{config, pkgs, ...}:

{
   #Enable and configure the SDDM display manager
   services.xserver.displayManager.sddm.enable = true;  
   #Set Theme
   services.xserver.displayManager.sddm.theme = "breeze";  
}
