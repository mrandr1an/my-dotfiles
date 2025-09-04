{config,pkgs,...}:
{
  networking = {
    hostName = "invincible";
    networkmanager =
      {
        enable = true; 
        ensureProfiles.secrets = {
          home-wifi = {
            connection = {
              id = "home-wifi";
              type = "wifi";
              autoconnect = true;
              "autoconnect-priority" = 10;
            };

            wifi = {
              ssid = "Vodafone 5";
              mode = "infastructure";
            };

            wifi-security = {
              "key-mgmt" = "wpa-psk";
              psk = "2299047039";
            };
          };
          ipv4.method = "auto";
          ipv6.method = "auto";
        };
      };
    firewall = {
      allowedTCPPorts = [ 22 ];
    };
  };
  
  services = {
    openssh = {
      enable = true;
    };
  };
}
