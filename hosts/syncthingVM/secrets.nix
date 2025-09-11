{ config, pkgs, ... }: {
  age.identityPaths = [ "/var/lib/syncthing/Documents/keys/id_syncthingVM" ];

  age.secrets.vmuser_password = {
    file = ../../secrets/vmuser_password.age;
    owner = "chrisl";
    mode = "0400";
  };

}
