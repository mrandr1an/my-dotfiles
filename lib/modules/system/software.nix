#lib/modules/system/software.nix
{config,lib,...}:
let
  inherit (lib) mkOption types;
  cfg = config.syssoftware;
in
{
  options.syssoftware= {

    network = {
      hostname = mkOption {
        type = types.str;
        default = "nixos";
      };

      allowedTCPPorts = mkOption {
        type = types.listOf lib.types.int;
        default = [];
      };

      allowedUDPPorts = mkOption {
        type = types.listOf lib.types.int;
        default = [];
      };

      ssh = {
        enable = lib.mkEnableOption "Enable ssh.";
      };
    };

    audio = {
      enable = lib.mkEnableOption  "Enable the audio stack.";
    };

    bluetooth = {
      enable = lib.mkEnableOption "Enable the bluetooth stack.";
    };

  };

  config = lib.mkMerge [

    {
     boot.loader.systemd-boot.enable = true;
     boot.loader.efi.canTouchEfiVariables = true;

     system.stateVersion = "25.05";

     nix.settings.experimental-features = [ "nix-command" "flakes" ];
    }

    {
      networking.hostName = cfg.network.hostname;
      networking.firewall.allowedTCPPorts = cfg.network.allowedTCPPorts;
      networking.firewall.allowedUDPPorts = cfg.network.allowedUDPPorts;
    }

    (lib.mkIf cfg.audio.enable {
      security.rtkit.enable = true;

      services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;  # provides a PulseAudio-compatible server
        jack.enable  = false;
      }; 
    })

    (lib.mkIf cfg.bluetooth.enable {
      hardware.bluetooth.enable = cfg.bluetooth.enable;
      services.blueman.enable = lib.mkIf cfg.bluetooth.enable true; 
    })
    
    (lib.mkIf cfg.ssh.enable {
      services.openssh = {
        enable = cfg.network.ssh.enable;
      };
    })
    
  ];
}
