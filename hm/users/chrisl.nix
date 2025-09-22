#hm/users/chrisl.nix
{config,pkgs,lib,desktopChoices,...}:
let
  choices = desktopChoices;
in
{  
  imports =
    lib.optional (choices.window-manager == "niri") ../modules/niri.nix;

  home = {
    username = "chrisl";
    homeDirectory = "/home/chrisl";
    stateVersion = "25.05";
  };

  config  = lib.mkMerge [
    (lib.mkIf (choices.window-manager == "niri") {
      desktop-environment.window-manager.niri = {
        enable = true;
        src = ../../dotfiles/niri/config.kdl;
      };
    })
  ];

}
