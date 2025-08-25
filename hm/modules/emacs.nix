#hm/modules/emacs.nix
{config,lib,pkgs, ...} :
let
  cfg = config.apps.emacs;
  overlay =
    lib.mkIf cfg.ovelay.enable
    (import (builtins.fetchTarball {
      url = cfg.overlay.url;
      sha256 = cfg.overlay.sha256;
    }));
  pkgsEmacs =
    if cfg.overlay.enable then
      import pkgs.path
        {
          system = pkgs.system;
          overlays = [ overlay ];
          config = pkgs.config;
        }
    else
     pkgs; 
  baseEmacs =
    let
      base =
        if cfg.package.variant == "pgtk" then pkgsEmacs.emacs-unstable-pgtk
        else if cfg.package.variant == "gtk" then pkgs.Emacs.emacs-unstable
        else pkgsEmacs.emacs-unstable-nox;
    in
      base.override { withTreeSitter = cfg.package.withTreeSitter; };

  myEmacs =
    if cfg.use-package.enable then
      pkgsEmacs.emacsWithPackagesFromUsePackage
      {
        packages = baseEmacs;
        config =
          if cfg.usePackage.initFile != null then
            builtins.readFile cfg.usePackage.initFile
          else
            (cfg.usePackage.initText or "");
        extraEmacsPackages =
          (cfg.usePackage.extraEmacsPackages or
            (epkgs: [epkgs.use-package
                     epkgs.treesit-grammars.with-all-grammars]));
      }
    else
      baseEmacs;
in
{
  options.apps.emacs = {
    enable = lib.mkEnableOption "Emacs (package + optional daemon)";
    url = lib.mkOption {
      type = lib.types.str;
      default = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      description = "Tarball for emacs-overlay";
    };

    package = lib.mkOption {
      type = lib.types.enum ["pgtk" "gtk" "nox"];
      default = "pgtk";
      description = "Which Emacs build familly to use";
    };

    withTreeSitter = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable TreeSitter in base-emacs";
    };

    extraEmacsPackages = lib.mkOption {
      # Intentionally a function (epkgs: [ ... ])
      type = lib.types.raw;
      default = null;
      description =
        "Function epkgs: [...] appended in emacsWithPackagesFromUsePackage";
    };

    service = {
      enable = lib.mkEnableOption "Run emacs --daemon via HM services.emacs";
      client = lib.mkOption
        { type = lib.types.bool; default = true; };
      socketActivation = lib.mkOption
        { type = lib.types.bool; default = true; };
      defaultEditor = lib.mkOption
        { type = lib.types.bool; default = true; };
      startWithUserSession = lib.mkOption
        { type = lib.types.bool; default = true; };
    };

    dotfiles = {
      enable = lib.mkEnableOption "Link a .emacs.d directory";
      path = lib.mkOption {
        type = with lib.types; path;
        default = /home/chrisl/.dotfiles/dotfiles/emacs;
        description = "Filesystem path to link as ~/.emacs.d.";
      };
      force = lib.mkOption { type = lib.types.bool; default = true; };
    };
    
    config = lib.mkIf cfg.enable {
     programs.emacs = {
      enable = true;
      package = myEmacs;
    };

    services.emacs = lib.mkIf cfg.service.enable {
      enable = true;
      package = myEmacs;
      client.enable = cfg.service.client;
      socketActivation.enable = cfg.service.socketActivation;
      defaultEditor = cfg.service.defaultEditor;
      startWithUserSession = cfg.service.startWithUserSession;
    };

    # Optional dotfiles link (mutually exclusive with usePackage)
    home.file.".emacs.d" = lib.mkIf cfg.dotfiles.enable {
      source = config.lib.file.mkOutOfStoreSymlink cfg.dotfiles.path;
      force = cfg.dotfiles.force;
    };
  };
  };
}
