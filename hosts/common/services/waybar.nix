{config, pkgs, ...}:
{   
   environment.systemPackages = 
	    [
		pkgs.waybar
            ];
}
