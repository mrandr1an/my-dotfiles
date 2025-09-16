#lib/modules/display-managers/regreet.nix
{command'}:
{pkgs,config,lib,archetype}:
let
cfg = config.desktop.display-managers.regreet;
in
{ 
  options.desktop.display-managers.regreet= {
    enable = lib.mkEnableOption "Enable ReGreet as the display manager.";

    gtkTheme = lib.mkOption {
      type = lib.types.submodule {
        options = {
            name = lib.mkOption {
            type = lib.types.str;
            example = "Adwaita";
            };

            package = lib.mkOption {
            type = lib.types.package;
            example = pkgs.gnome-themes-extra;
            };
        };
      };
    };

    iconTheme = lib.mkOption {
      type = lib.types.submodule {
        options = {
            name = lib.mkOption {
            type = lib.types.str;
            example = "Adwaita";
            };

            package = lib.mkOption {
            type = lib.types.package;
            example = pkgs.adwaita-icon-theme;
            };
        };
      };
    };

    font = lib.mkOption {
      type = lib.types.submodule {
        options = {
            name = lib.mkOption {
            type = lib.types.str;
            example = "Cantarell";
            };

            package = lib.mkOption {
            type = lib.types.package;
            example = pkgs.cantarell-fonts;
            };

            size = lib.mkOption {
            type = lib.types.number;
            example = 16;
            };
        };
      };
    };

    extraCss = lib.mkOption {
      type = lib.types.str;
    };

  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = command';
          user = archetype.user.userName;
        };
      };
    };

    programs.regreet = {
      enable = true;
      theme = {
        name = cfg.gtkTheme.name;
        package = cfg.gtkTheme.package;
      };

      iconTheme = {
        name = cfg.iconTheme.name;
        package = cfg.iconTheme.package;
      };

      font = {
        name = cfg.font.name; 
        package = cfg.font.package;
        size = cfg.font.size;
      };
    };
  };
}
