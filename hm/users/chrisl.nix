#hm/users/chrisl.nix
{config,pkgs,lib,desktop,...}:
let
  choices = desktop;
in
{  
  imports = [
    ../modules/desktop-environment
    # ../modules/apps
    # ../modules/core
  ];

  home = {
    username = "chrisl";
    homeDirectory = "/home/chrisl";
    stateVersion = "25.05";
  };

  desktop-environment =
    let
      enableDE = choices.enable;
    in
      {
        enable = enableDE;
      };
}
