{ config, pkgs, ... }: {

  users.users.chrisl = {
    isNormalUser = true;
    description = "Chris Liourtas";
    extraGroups = [ "networkmanager" "wheel" "ubridge" ];
    initialPassword = "changeme";
  };

  users.groups.libvirtd.members = ["chrisl"];
  users.groups.ubridge.members = ["chrisl"];
}

