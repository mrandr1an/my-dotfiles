#lib/modules/locale.nix
{config, lib, ...}:
let
  cfg = config.locale;
in
{
  options.locale = {
    timeZone = lib.mkOption {
      type = lib.types.str;
      description = "Timezone of system";
    };
  };

  config = {
    time.timeZone = cfg.timeZone;
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "el_GR.UTF-8";
      LC_IDENTIFICATION = "el_GR.UTF-8";
      LC_MEASUREMENT = "el_GR.UTF-8";
      LC_MONETARY = "el_GR.UTF-8";
      LC_NAME = "el_GR.UTF-8";
      LC_NUMERIC = "el_GR.UTF-8";
      LC_PAPER = "el_GR.UTF-8";
      LC_TELEPHONE = "el_GR.UTF-8";
      LC_TIME = "el_GR.UTF-8";
    };
  };
}
