{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    git
    qemu
    alacritty
    rpi-imager
    ubridge
    nerd-fonts.jetbrains-mono
    nerd-fonts.comic-shanns-mono
    nerd-fonts.symbols-only
    pkgs.mako
    pkgs.quickshell
  ];

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}

