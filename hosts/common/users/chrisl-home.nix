{config, pkgs, ...} :
{
  imports = [
    ../../../hm/modules/emacs.nix
    ../../../hm/modules/git.nix
  ];

  apps.emacs =  {
    enable = true;
    package = "pgtk";
    overlay.enable = true;
    withTreeSitter = true; 
    service.enable = true;
    dotfiles.enable = true;
  };

  config.dev = {
    git = {
      enable = true;
      userName = "mrandr1an";
      userEmail = "krackedissad@gmail.com";
    };
  };
    
home.username = "chrisl";
home.homeDirectory = "/home/chrisl";
home.stateVersion = "25.05";


services.syncthing = {
  enable = true;
 };

programs = {
  direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };
  bash.enable = true; # see note on other shells below
};

home.file.".config/niri/".source = ../../../dotfiles/niri;
home.file.".config/waybar/".source = ../../../dotfiles/waybar;
home.file.".config/quickshell/".source = ../../../dotfiles/quickshell;
  
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
   pkgs.texliveFull
   pkgs.times-newer-roman
   pkgs.lmmath
   pkgs.ghostscript
   pkgs.imagemagick
 ];
}
