#lib/modules/display-managers/regreet.nix
{cmd}:
{pkgs,config,lib,archetype,...}:
let
cfg = config.desktop.display-managers.regreet;
command' = cmd;
in
{ 
  options.desktop.display-managers.regreet= {
    enable = lib.mkEnableOption "Enable ReGreet as the display manager.";

    gtkTheme = lib.mkOption {
      type = lib.types.submodule {
        options = {
            name = lib.mkOption {
            type = lib.types.str;
            default = "Adwaita";
            example = "Adwaita";
            };

            package = lib.mkOption {
            type = lib.types.package;
            example = pkgs.gnome-themes-extra;
            default = pkgs.gnome-themes-extra;
            };
        };
      }; 
      default = {
        name = "Adwaita";
        package = pkgs.gnome-themes-extra;
      };
    };

    iconTheme = lib.mkOption {
      type = lib.types.submodule {
        options = {
            name = lib.mkOption {
            type = lib.types.str;
            default = "Adwaita";
            example = "Adwaita";
            };

            package = lib.mkOption {
            type = lib.types.package;
            default = pkgs.adwaita-icon-theme;
            example = pkgs.adwaita-icon-theme;
            };
        };
      };
      default = {
          name = "Adwaita";
          package = pkgs.adwaita-icon-theme;
        };
    };

    font = lib.mkOption {
      type = lib.types.submodule {
        options = {
            name = lib.mkOption {
            type = lib.types.str;
            default = "Cantarell";
            example = "Cantarell";
            };

            package = lib.mkOption {
            type = lib.types.package;
            example = pkgs.cantarell-fonts;
            default = pkgs.cantarell-fonts;
            };

            size = lib.mkOption {
            type = lib.types.number;
            example = 16;
            default = 16;
            };
        };
      };
      default = {
          name = "Cantarell";
          package = pkgs.cantarell-fonts;
        };
    };

    extraCss = lib.mkOption {
      type = lib.types.str;
      default = "";
    };

  };

  config = lib.mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = command';
          user = archetype.laptop.user.userName;
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
