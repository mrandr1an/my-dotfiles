#lib/modules/system/hardware.nix
{config,lib,modulesPath,...}:
let
  inherit (lib) mkOption types;
  cfg = config.syshardware;
in
{
  options.syshardware = {

    qemu = {
      enable = lib.mkEnableOption "Enable qemu virtual hardware.";
      arch = mkOption {
        type = types.str;
        default = "x86_64-linux" ;
      };
      guest = mkOption {
        type = types.bool;
        default = true;
      };
      availableKernelModules = mkOption {
        type = types.listOf types.str;
        default = ["uhci_hcd" "ehci_pci" "ahci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod"];
      };
    };

    physical = {
      enable = lib.mkEnableOption "Enable physical hardware.";
      arch = mkOption {
        type = types.str;
        default = "x86_64-linux" ;
      };
      availableKernelModules = mkOption {
        type = types.listOf types.str;
        default = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod"];
      };
      kernelModules = mkOption {
        type = types.listOf types.str;
        default = ["kvm-intel"];
      };
    };

  };

  config = lib.mkMerge [

    (lib.mkIf cfg.qemu.enable {
      imports = []
                ++ lib.optionals (cfg.qemu.guest == true)
                  [(modulesPath + "/profiles/qemu-guest.nix")];

      boot.initrd.availableKernelModules = cfg.qemu.availableKernelModules;
      nixpkgs.hostPlatform = lib.mkDefault cfg.qemu.arch;
    })

    (lib.mkIf cfg.physical.enable {
      boot.initrd.availableKernelModules = cfg.physical.availableKernelModules;
      boot.kernelModules = cfg.physical.kernelModules;
      nixpkgs.hostPlatform = lib.mkDefault cfg.physical.arch;
    })
  ];
}
