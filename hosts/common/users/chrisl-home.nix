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

 services.syncthing = {
  enable = true;
 };

services.emacs = {
 enable = true;
 client.enable = true;
 socketActivation.enable = true;
 defaultEditor = true;
 startWithUserSession = true;
};

 programs.emacs =
    let
      emacsConfigFile = ../../..dotfiles/my-emacs;
      parse = pkgs.callPackage (flake.inputs.emacs-overlay + /parse.nix) { };
    in
    {
      enable = true;
      package = pkgs.emacs-pgtk;
      extraPackages =
        epkgs:
        builtins.map (name: builtins.getAttr name epkgs) (
          parse.parsePackagesFromUsePackage {
            alwaysEnsure = true;
            configText = builtins.readFile emacsConfigFile;
          }
        )
        ++ [
          (epkgs.treesit-grammars.with-grammars (
            grammars: with grammars; [
              # keep-sorted start
              tree-sitter-bash
              tree-sitter-typst
              # keep-sorted end
            ]
          ))
        ];
      extraConfig = ''
        (load "${emacsConfigFile}")
	'';
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
 ];

}
