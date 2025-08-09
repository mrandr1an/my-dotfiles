{ config, pkgs, ... }:
let
  # Choose the Emacs you want:
  #   pkgs.emacs         (GTK)
  #   pkgs.emacsPgtk     (PGTK)
  #   pkgs.emacs-unstable (from emacs-overlay, if you wired it)
  baseEmacs = pkgs.emacs;

  emacsPkgs = pkgs.emacsPackagesFor baseEmacs;
in
{
  environment.systemPackages = [
    (emacsPkgs.emacsWithPackagesFromUsePackage {
      package = emacsPkgs.emacs;     # ← use the emacs from this package set
      config  = ../../../dotfiles/emacs/init.el;            # ← stable path; keep it near the module

      extraEmacsPackages = epkgs: with epkgs; [
        use-package
        # add packages that your init.el requires but can't infer
        # e.g. magit org-contrib consult orderless vertico
      ];

      # Optional helpers:
      # alwaysEnsure = true;  # treat :ensure as true by default
      # alwaysTangle = true;  # if you keep org-babel configs
    })
  ];
}

