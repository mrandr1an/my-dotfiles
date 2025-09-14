#hm/users/vmuser.nix
{config,pkgs,...}:
{

  home.username = "vmuser";
  home.homeDirectory = "/home/vmuser";
  home.stateVersion = "25.05";

  services = {

  };

  home.packages = with pkgs;
    [
      git
      vim
    ];
}
