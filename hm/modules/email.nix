#hm/modules/email.nix
{config,lib,pkgs,...} :
let
 cfg = config.apps.email;
in
{
  options.apps.email =
  {
    enable = lib.mkEnableOption "Email (send + read)";

    syncer = lib.mkOption {
      type = lib.types.enum [ "mbsync" ];
      default = "mbsync";
      description = "Package to pull/push mail via IMAP.";
    };

    sender = lib.mkOption {
      type = lib.types.enum [ "msmtp" ];
      default = "msmtp";
      description = "Package to actually send mail.";
    };

    indexer = lib.mkOption {
      type = lib.types.enum [ "notmuch" "mu" ];
      default = "mu";
      description = "Mail indexer.";
    };

    client = lib.mkOption {
      type = lib.types.enum [ "emacs" "thunderbird" ];
      default = "emacs";
      description = "Mail Client.";
    };

    account = lib.mkOption {
      description = "Single account parameters.";
      type = lib.types.submodule
        {
          address = lib.mkOption {
            type = lib.types.str;
            example = "your@domain.tld";
          };

          userName = lib.mkOption {
            type = lib.types.str;
            example = "Your Name";
          };

          realName = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
          };
        };
    };

    imap = lib.mkOption {
      type = lib.types.submodule {
        host = lib.mkOption { type = lib.types.str; };
        tls = lib.mkOption { type = lib.types.bool; default = true;};
        port = lib.mkOption { type = lib.types.int; default = 993;};
      };
    };

    smtp = lib.mkOption {
      type = lib.types.submodule {
        host = lib.mkOption { type = lib.types.str; };
        tls = lib.mkOption { type = lib.types.bool; default = true;};
        port = lib.mkOption { type = lib.types.int; default = 465;};
      };
    };

    mailDirName = lib.mkOption {
      type = lib.types.str;
      default = "hostinger";
      description = "Subdirectory under maildirBase used for this account.";
    };

    mailDirBase = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null; # defaults to ~/Mail at evaluation time
    };

    passwordFile = lib.mkOption {
       type = lib.types.nullOr lib.types.path;
       default = null;
       description =
         "Path to secret file (agenix). Used to build a passwordCommand.";
    };

    passwordCommand = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
    };

    folders = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        inbox = "INBOX";
        sent = "sent";
        drafts = "drafts";
        trash = "trash";
        archive = "archive";
        junk = "junk";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    
  };
}
