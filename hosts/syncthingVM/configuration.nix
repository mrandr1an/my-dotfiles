{config,pkgs,...} :
{
  imports =
    [
      ./hardware-configuration.nix
      ./locale.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.05";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  security.rtkit.enable = true;
  
  services = {
    openssh = {
      enable = true;
    };

    syncthing = {
      enable = true;
      systemService = true;
      # Keep GUI local; use SSH tunnel when you need to administer.
      guiAddress = "127.0.0.1:8384";
      settings = {
        devices = {
          "invincible" = { id = "QPWTCNV-QN7YCKR-I2VOFE2-VJK7LOA-YUF6IGI-2N4YPGK-3XKAZOH-BU4SSAK";};
        };
        folders = {
          "Documents" = {
            path = "/var/lib/syncthing/Documents";
            devices = [ "invincible" ];
          };
        };
      };
    };

  };

  #Allow only what is needed by Syncthing
  networking.firewall.allowedTCPPorts = [ 22000 ];
  networking.firewall.allowedUDPPorts = [ 22000 21027 ];

  users.users.vmuser = {
    isNormalUser = true;
    hashedPassword = "changeme";
    extraGroups = [ "wheel" ]; # gives sudo access
  };
}
