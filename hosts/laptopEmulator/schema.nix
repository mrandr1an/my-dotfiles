{
  arch = "x86_64-linux";
  
  user = "chrisl";
  
  desktop-environment = {
    enable = true;
    
    window-manager = {
      enable = true;
      niri = {
        enable = true;
      };
    };
  };

  virtual-machine = {
    enable = true;
    hostname = "invincible";
  };

  disks = {
    main = {
      id = "scsi-0QEMU_QEMU_HARDDISK_drive-scsi0";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };

          luks-root = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              passwordFile = "/tmp/disk-1.key"; 
              content = {
                type = "btrfs";
                extraArgs = ["-f"]; 
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  "@var" = {
                    mountpoint = "/var";
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  "@log" = {
                    mountpoint = "/var/log";
                    mountOptions = ["compress=zstd" "noatime"];
                  };

                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
