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
    pkgs.quickshell
    pkgs.nixd
   (python3.withPackages (ps: with ps; [
    epc orjson sexpdata six setuptools paramiko rapidfuzz watchdog packaging
   ]))
  ];

  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}

