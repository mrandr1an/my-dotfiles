#hm/modules/waybar.nix
{config, lib, pkgs, ...} :
let
  cfg = config.desktop-environment.window-managers.status-bar;
in
{
  
  options.desktop-environment
    .window-managers.status-bar = {
    enable = lib.mkEnableOption "Enable waybar."; 
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
         enable = true;
         package = pkgs.waybar;
         settings = {
            mainBar = {
            layer = "top";
            position = "top";
            height = 30;

            # Keys with hyphens must be quoted in Nix
            "gtk-layer-shell" = true;
            "margin-top" = 6;
            "margin-left" = 6;
            "margin-right" = 6;

            spacing = 8;

            modules-left = [ "niri/workspaces" ];
            modules-center = [ "clock#date" "clock#time" ];
            modules-right = [ "niri/language" "network" "audio" "battery" "tray" ];

            "niri/workspaces" = {
                format = "{index}";
                on-click = "activate";
                disable-scroll = true;
            };

            "niri/language" = {
                format = "{short}";
                "format-en" = "EN";
                "format-el" = "EL";
            };

            "clock#date" = {
                format = " {:%A %d %b %Y}";
                tooltip-format = "{:%A, %d %B %Y}";
            };

            "clock#time" = {
                format = "{:%H:%M}";
                tooltip-format = "{:%H:%M:%S}";
            };

            "network" = {
                interval = 2;
                format-wifi = "  {essid} {signalStrength}%";
                format-ethernet = "󰈁  {ifname}";
                format-disconnected = "󰖪  Offline";
                tooltip-format = "{ifname} • up {bandwidthUpBits} / down {bandwidthDownBits}";
                max-length = 22;
            };
            };
         };

        style = ./style.css;
     };
  };
}
