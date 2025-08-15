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
 package = pkgsEmacs.emacs-unstable-pgtk;
 client.enable = true;
 socketActivation.enable = true;
 defaultEditor = true;
 startWithUserSession = true;
};

programs.emacs = {
  enable = true;                                 
  package = pkgsEmacs.emacs-unstable-pgtk;
};

home.file.".config/niri/".source  = ../../../dotfiles/niri;
home.file.".config/waybar/".source  = ../../../dotfiles/waybar;
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
   (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacsGit;  # replace with pkgs.emacsPgtk, or another version if desired.
      config = ../../../dotfiles/emacs;

      extraEmacsPackages = epkgs: [
        epkgs.use-package;
      ];

    })
 ];

}
