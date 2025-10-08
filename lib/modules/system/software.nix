#lib/modules/system/software.nix
{config,lib,pkgs,...}:
let
  inherit (lib) mkOption types;
  cfg = config.syssoftware;
in
{
  imports = [
    ../display-managers/regreet.nix
  ];

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
     boot = {
       plymouth = {
         enable = true;
         theme = "cubes";
         themePackages = with pkgs; [
           # By default we would install all themes
           (adi1090x-plymouth-themes.override {
             selected_themes = [ "cubes" ];
           })
         ];
       };
       initrd.systemd.enable = true;
       # Enable "Silent boot"
       consoleLogLevel = 3;
       initrd.verbose = false;
       kernelParams = [
         "quiet"
         "splash"
         "boot.shell_on_fail"
         "udev.log_priority=3"
         "rd.systemd.show_status=auto"
       ];
       # Hide the OS choice for bootloaders.
       # It's still possible to open the bootloader list by pressing any key
       # It will just not appear on screen unless a key is pressed
       loader = {    
         timeout = 0;
         systemd-boot.enable = true;
         efi.canTouchEfiVariables = true;
       };
     };
     system.stateVersion = "25.05";

     nix.settings.experimental-features = [ "nix-command" "flakes" ];
    }

    #Display Manager
    {
      desktop.display-managers.regreet = {
        enable = true;
      };
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
    
    (lib.mkIf cfg.network.ssh.enable {
      services.openssh = {
        enable = cfg.network.ssh.enable;
      };
    })
  ];
}
