{config, pkgs, ...} :

{

 home.username = "chrisl";
 home.homeDirectory = "/home/chrisl";
 home.stateVersion = "25.05";

 #Git Options
 programs.git = 
 {
   enable = true;
   userName = "mrandr1an";
   userEmail = "krackedissad@gmail.com";

   extraConfig = {
	init.defaultBranch = "main";
   };
 }; 

 #Emacs Options
 programs.emacs = {
  enable = true;
  package = pkgs.emacs;
 };

 services.emacs = {
  enable = true;
  package = pkgs.emacs;
 };

 services.syncthing = {
  enable = true;
 };
 
#home.file.".emacs.d".source = ../../../dotfiles/my-emacs;

home.file.".config/niri/".source  = ../../../dotfiles/niri;
home.file.".config/waybar/".source  = ../../../dotfiles/waybar;
home.file.".config/mako/".source  = ../../../dotfiles/mako;
home.file.".config/quickshell/".source  = ../../../dotfiles/quickshell;
  
 #Home Packages
 home.packages = with pkgs;
 [
   gns3-gui   
   gns3-server
   ubridge
   virt-viewer
   nerd-fonts.jetbrains-mono
   nerd-fonts.comic-shanns-mono
   nerd-fonts.symbols-only
   pkgs.feishin
   pkgs.bitwarden-desktop
   pkgs.ansible_2_17
   pkgs.walker
   pkgs.bluez
   pkgs.sioyek
 ];

}
