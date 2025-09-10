{config, lib, pkgs, ...} :
let
  cfg = config.network;
in
{
  options.network = {

    enable = lib.mkEnableOption "Declarative NetworkManager profiles (Ethernet + WiFi) + network hostname";

    hostname = lib.mkOption {
      type = lib.types.str;
      example = "laptop";
    };

    ethernet = {

    };

    wifi = {

    };

    networks = lib.mkOption {
      default = {};
      type = lib.types.attrsOf (lib.types.submodule ({name,...}:{

      }));
    };
  };
}
