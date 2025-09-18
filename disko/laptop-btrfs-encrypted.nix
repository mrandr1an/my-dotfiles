#disko/laptop-btrfs-encrypted.nix
{hdd,ssd}:
{
  disko.devices = {

    disk.nvme0n1 = {
      device = hdd.name or "/dev/disk/by-id/nvme-eui.002303563020df0f";
      type = "disk";
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
              content = {
                type = "btrfs";
                extraArgs = "-f";
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

                };
              }; 
            };
          };
        };
      };
    };
    
    disk.sda = {
      device = ssd.name or "/dev/disk/by-id/ata-WDC_WD10SPZX-24Z10_WD-WXM1AC9JLR5C";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          luks-data = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptdata";
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "@data" = {
                    mountpoint = "/data";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "@backup" = {
                    mountpoint = "/backup";
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

 disko.enableConfig = true;
}
