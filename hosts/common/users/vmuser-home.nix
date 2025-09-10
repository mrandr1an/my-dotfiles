{config, pkgs, ...} :
{
  imports = [
    ../../../hm/modules/git.nix
  ];

  home.username = "vmuser";
  home.homeDirectory = "/home/vmuser";
  home.stateVersion = "25.05";

  dev = {
    git = {
      enable = true;
      userName = "mrandr1an";
      userEmail = "krackedissad@gmail.com";
    };
  };
  
}
