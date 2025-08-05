{ config, pkgs, ... }: 
{
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}
