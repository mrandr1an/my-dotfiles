#lib/modules/hardware/hardware.nix
{config,lib,modulesPath,...}:
let
  inherit (lib) mkOption types;
  cfg = config.hardware;
in
{
  options.hardware = {

    qemu = mkOption {
      type =  types.submodule {
        options = {
          enable = lib.mkEnableOption "Enable qemu virtual hardware.";
          arch = mkOption {
            type = types.str;
            default = "x86_64-linux";
          };
          qemuGuestAgent = mkOption {
            enable = lib.mkEnableOption "Enable qemu guest agent.";
            default = false;
          };
        };
      };

      default = {
        qemuGuestAgent = true;
      };

    };

    physical = {

    };

    settings = {

      networking = mkOption {
        type = types.submodule {
          options = {
            enable = lib.mkEnableOption "Enable networking.";
            useDHCP = mkOption {
              type = types.bool;
              default = false;
            };
          };
        };
      };

      audio = mkOption {

      };

      bluetooth = mkOption {

      };
 
    };

  };

  config = lib.mkMerge [

    (lib.mkIf cfg.hardware.physical != null throw "Physical machine hardware not implemented yet.")

    (lib.mkIf cfg.hardware.qemu != null {
       imports =
         [
           (modulesPath + "/profiles/qemu-guest.nix")
         ];

        boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "virtio_pci" "virtio_scsi" "sd_mod" "sr_mod"];

        nixpkgs.hostPlatform = cfg.qemu.arch;

        networking.useDHCP = cfg.settings.networking.useDHCP;
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        system.stateVersion = "25.05";

        nix.settings.experimental-features = [ "nix-command" "flakes" ];
    })
  ];
}
