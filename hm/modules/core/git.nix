#hm/modules/git.nix
{config, lib, pkgs, ...} :
let
  cfg = config.dev.git;
in
{
  options.dev.git = {
    enable = lib.mkEnableOption "Git via home-manager module.";

    userName = lib.mkOption {
      type = lib.types.str;
      description = "Git username."; 
    };

    userEmail = lib.mkOption {
      type = lib.types.str;
      description = "Git user email."; 
    };

  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
