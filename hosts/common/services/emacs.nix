{config, pkgs, ...}:
{
  environment.systemPackages = [
    (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacsGit;  # replace with pkgs.emacsPgtk, or another version if desired.
      config = ../../../dotfiles/emacs/;

      extraEmacsPackages = epkgs: [
        epkgs.use-package;
      ];

    })
  ];
 }
