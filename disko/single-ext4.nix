#disko/single-ext4.nix
{ lib, devices, sizes ? { esp = "512MiB"; root = "100%"; }, ... }:
{
  disko.devices = {
    disk.main = {
      device = lib.mkDefault (devices.disk or "/dev/vda");
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            name  = "ESP";
            start = "1MiB";
            size  = sizes.esp;
            type  = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          root = {
            size = sizes.root;
            type = "8300";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };

  # Generate fileSystems entries from the above
  disko.enableConfig = true;
}
