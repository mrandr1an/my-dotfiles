{ config, lib, pkgs, ... }:
let
  epkgs = pkgs.emacsPackagesFor pkgs.emacs;  # or pkgs.emacs29, etc.
in {
  environment.systemPackages = [
    (epkgs.emacsWithPackagesFromUsePackage {
      package = epkgs.emacs;
      config = ./init.el;   # point to your init
      extraPackages = epkgs: with epkgs; [ vterm ];
    })
  ];
}

