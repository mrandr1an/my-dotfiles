{ config, pkgs, ... }: {
  age.identityPaths = [ "/var/lib/syncthing/Documents/keys/id_syncthingVM" ];

  age.secrets.vmuser_password = {
    file = ../../secrets/vmuser_password.age;
    owner = "vmuser";
    mode = "0400";
  };

}
