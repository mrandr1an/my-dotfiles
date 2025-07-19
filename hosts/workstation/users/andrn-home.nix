{config, pkgs, ...} :

{
 home.username = "andrn";
 home.homeDirectory = "/home/andrn";
 home.stateVersion = "25.05";
 
 programs.bash = {
  enable = true;
  shellAliases = {
    btw = ''echo "i am andrn motherfucker"'';};
 };
}
