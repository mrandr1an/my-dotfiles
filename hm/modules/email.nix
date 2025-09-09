#hm/modules/email.nix
{ config, pkgs,lib, ... }:
let
  cfg = config.services.email;
  imapHost = "imap.hostinger.com";
  smtpHost = "smtp.hostinger.com";
  mailPoll = pkgs.writeShellApplication {
    name = "mail-poll";
    runtimeInputs = with pkgs; [ isync mu libnotify coreutils gnugrep ];
    text = ''
        set -euo pipefail
        STATE_HOME="$(printenv XDG_STATE_HOME 2>/dev/null || true)"
        if [ -z "$STATE_HOME" ]; then
           STATE_HOME="$HOME/.local/state"
        fi
        STATE_DIR="$STATE_HOME/mail-poll"
        TS_FILE="$STATE_DIR/last-ts"
        mkdir -p "$STATE_DIR"

        # 1) sync
        mbsync -a

        # 2) init mu once (remembers maildir & personal address)
        if ! mu info >/dev/null 2>&1; then
          mu init --maildir="/home/chrisl/Maildir/Mail/kracked.tech" --my-address="${cfg.address}"
        fi

        # 3) index (incremental after first run)
        mu index --quiet

        # 4) compute "since" watermark
        if [ ! -s "$TS_FILE" ]; then
          date -d '5 minutes ago' +%s > "$TS_FILE"
        fi

        # 5) find new unread mail since last run; ignore Trash/Spam
        NEW=$(
          mu find 'flag:unread AND NOT maildir:/Trash AND NOT maildir:/Spam' \
            --fields 'd f s' --sortfield=date --reverse || true
        )
        count=$(printf '%s\n' "$NEW" | grep -c . || true)

        if [ "$count" -gt 0 ]; then
          summary="$count new email$([ "$count" -gt 1 ] && printf 's')"
          body=$(printf '%s\n' "$NEW" | head -n 5)
          notify-send -a mu "$summary" "$body"
        fi

        # 6) advance watermark
        date +%s > "$TS_FILE"
    '';
  };
in
{
  options.services.email = {
    enable = lib.mkEnableOption "Email Service.";

    address = lib.mkOption {
      type = lib.types.str;
      default = "cliourtas@kracked.tech";
      description = "Primary email address (also used as username by default).)";
    };

    userName = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null; #falls back to address
      description = "IMAP/SMTP login username. Defaults to address when null.";
    };

    realName = lib.mkOption {
      type = lib.types.str;
      default = "Chris Liourtas";
      description = "Display name for outgoing mail.";
    };

    maildirPath = lib.mkOption {
      type = lib.types.str;
      default = "Mail/kracked.tech";
      description = "Maildir path relative to $HOME.";
    };

    syncFrequency = lib.mkOption {
      type = lib.types.str;
      default = "*:0/5"; # every 5 minutes
      description = "Systemd OnCalendar spec for periodic mbsync.";
    };

    passwordCommand = lib.mkOption {
      type = lib.types.str;
      default = "cat /run/agenix/email_password";
      description = "Command that prints the mailbox password.";
    };

    folders = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {
        inbox  = "Inbox";
        drafts = "Drafts";
        sent   = "Sent";
        trash  = "Trash";
      };
      description = "Server folder names used for special folders.";
    };

    accountName = lib.mkOption {
      type = lib.types.str;
      default = "hostinger";
      description = "Identifier for the generated Home-Manager email account.";
    };
  };

  config = lib.mkIf cfg.enable {
      programs.mbsync.enable = true;
      programs.msmtp.enable  = true;

      accounts.email = {
        accounts.${cfg.accountName} = {
          primary   = true;
          address   = cfg.address;
          userName  = cfg.userName or cfg.address;
          realName  = cfg.realName;
          flavor    = "plain";

          imap = {
            host = imapHost;
            port = 993;
            tls.enable = true;       
          };

          smtp = {
            host = smtpHost;
            port = 587;
            tls.enable = true;
          };

          maildir.path = cfg.maildirPath;

          mbsync = {
            enable = true;
            create = "maildir";
            subFolders = "Maildir++";
          };

          msmtp.enable  = true;

          folders = cfg.folders;

          passwordCommand = cfg.passwordCommand;
        };
      };
      
      # periodic sync
      # services.mbsync = {
      #  enable = true;
      # frequency = cfg.syncFrequency;
      # };

     systemd.user.services.mail-poll = {
      Unit.Description = "Sync mail (mbsync), index with mu, and notify on new mail";
      Service = {
        Type = "oneshot";
        ExecStart = "${mailPoll}/bin/mail-poll";
        Environment = [ "XDG_RUNTIME_DIR=%t" ];
      };
      Install.WantedBy = [ "default.target" ];
    };

    # run on your existing schedule (e.g. "*:0/5")
     systemd.user.timers.mail-poll = {
      Unit.Description = "Periodic mail poller";
      Timer = {
        OnCalendar = cfg.syncFrequency;
        Persistent = true;     # catch up after downtime
        Unit = "mail-poll.service";
      };
      Install.WantedBy = [ "timers.target" ];
    };
    };
}
