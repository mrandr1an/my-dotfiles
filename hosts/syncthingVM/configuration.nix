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

  security.wrappers.ubridge = {
    source = "/run/current-system/sw/bin/ubridge";
    capabilities = "cap_net_admin,cap_net_raw=ep";
    owner = "root";
    group = "ubridge";
    permissions = "u+rx,g+x,o+rx";
  };

  services = {
    openssh = {
      enable = true;
    };

    syncthing = {
      enable = true;
    };
  };

  users.users.vmuser = {
    isNormalUser = true;
    initialPassword = "changeme";
  };
}
