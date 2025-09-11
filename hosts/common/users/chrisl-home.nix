{config, pkgs, ...} :
{
  imports = [
    ../../../hm/modules/emacs.nix
    ../../../hm/modules/git.nix
    ../../../hm/modules/niri.nix
    ../../../hm/modules/email.nix
  ];

  home.username = "chrisl";
  home.homeDirectory = "/home/chrisl";
  home.stateVersion = "25.05";
  
  apps = {
    emacs =  {
      enable = true;
      package = "pgtk";
      overlay.enable = true;
      withTreeSitter = true; 
      service.enable = true;
      dotfiles.enable = true;
    };
  };

  dev = {
    git = {
      enable = true;
      userName = "mrandr1an";
      userEmail = "krackedissad@gmail.com";
    };
  };

  services = {
    syncthing = {
      enable = true;
      settings = {
        devices = {
          "syncthingVM" = { id = "X4YJML2-CW2W2II-HAP22JU-RN2F3HN-VJOF3GR-N2T47X4-W3PPHEF-WYAJNQ2"; };
        };
        folders =  {
          "Documents"= {
            path = "/home/chrisl/Documents";
            devices = [ "syncthingVM" ];
          };
        };
      };
    };
    email = {
      enable = true;
      userName = "cliourtas@kracked.tech";
    };
  };

  desktop-environment = {
    window-manager = {
      niri-config = {
	enable = true;
        src = builtins.readFile ../../../dotfiles/niri/config.kdl;
      };
    };
  };

  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    bash = {
      enable = true;
    };
    waybar = {
      enable = true;
    };
  };

  home.file.".config/waybar/".source = ../../../dotfiles/waybar;
  home.file.".config/mako/".source = ../../../dotfiles/mako;
 
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
   pkgs.mako
   pkgs.mu
 ];
}
