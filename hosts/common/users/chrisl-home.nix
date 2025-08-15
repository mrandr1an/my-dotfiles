{config, pkgs, ...} :
let 
emacsOverlay = 
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      sha256 = "sha256-+B/GngvxzeLxe5JXuJkXNc3k77jLiyb0p3rwvu5hLPA=";
    }));
pkgsEmacs = import pkgs.path {
 system = pkgs.system;
 overlays = [ emacsOverlay ];
 config = pkgs.config;
};
myEmacs = pkgsEmacs.emacsWithPackagesFromUsePackage {
 package = pkgsEmacs.emacs-unstable-pgtk;
 config = builtins.readFile ../../../dotfiles/emacs/init.el;
 extraEmacsPackages = epkgs: [ epkgs.use-package epkgs.nix-mode ];
};
in
{

home.username = "chrisl";
home.homeDirectory = "/home/chrisl";
home.stateVersion = "25.05";

#Git Options
programs.git = {
   enable = true;
   userName = "mrandr1an";
   userEmail = "krackedissad@gmail.com";
   extraConfig = {
	init.defaultBranch = "main";
   };
 }; 

services.syncthing = {
  enable = true;
 };

services.emacs = {
 enable = true;
 package = myEmacs;
 client.enable = true;
 socketActivation.enable = true;
 defaultEditor = true;
 startWithUserSession = true;
};

programs.emacs = {
  enable = true;                                 
  package = myEmacs;
};

home.file.".config/niri/".source = ../../../dotfiles/niri;
home.file.".config/waybar/".source = ../../../dotfiles/waybar;
home.file.".config/quickshell/".source = ../../../dotfiles/quickshell;
home.file.".emacs.d" = {
 source = config.lib.file.mkOutOfStoreSymlink /home/chrisl/.dotfiles/dotfiles/emacs; 
 force = true;
};
  
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
