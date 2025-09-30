#hm/users/chrisl.nix
{config,pkgs,lib,desktop,...}:
let
  choices = desktop;
in
{  
  imports =
    [ ../modules/niri.nix];

  config  = lib.mkMerge [
    {
      home = {
        username = "chrisl";
        homeDirectory = "/home/chrisl";
        stateVersion = "25.05";
      };
    }

    (lib.mkIf (choices.window-manager == "niri") {
      desktop-environment.window-manager.niri = {
        enable = true;
        src = ../../dotfiles/niri/config.kdl;
      };
    })
  ];

}
