# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
 let
  sddmService = import ../common/services/sddm.nix;
  niriService = import ../common/services/niri.nix;
  bitwardenService = import ../common/services/bitwarden.nix;
 in
{
  imports =
    [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Include Common Services
      sddmService
      niriService
      bitwardenService
    ];
  
  #System Level Secret
  age.secrets.secret1 = {
    file = ../../secrets/secret1.age;
    owner = "chrisl";
    mode = "0400";
  };
   
  age.identityPaths = ["/home/chrisl/.ssh/id_ed25519_host"];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vengeance"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Athens";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "el_GR.UTF-8";
    LC_IDENTIFICATION = "el_GR.UTF-8";
    LC_MEASUREMENT = "el_GR.UTF-8";
    LC_MONETARY = "el_GR.UTF-8";
    LC_NAME = "el_GR.UTF-8";
    LC_NUMERIC = "el_GR.UTF-8";
    LC_PAPER = "el_GR.UTF-8";
    LC_TELEPHONE = "el_GR.UTF-8";
    LC_TIME = "el_GR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chrisl = {
    isNormalUser = true;
    description = "Chris Liourtas";
    extraGroups = [ "networkmanager" "wheel" "ubridge" ];
    initialPassword = "changeme";
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  users.users.andrn = {
    isNormalUser = true;
    description = "Chris Liourtas";
    extraGroups = [ "networkmanager" "wheel" ];
    initialPassword = "changeme";
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  # Install hyprland
  programs.hyprland.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; 
  [
    vim
    git
    pkgs.qemu
    pkgs.alacritty
    pkgs.rpi-imager
    ubridge
    nerd-fonts.jetbrains-mono
    nerd-fonts.comic-shanns-mono
    nerd-fonts.symbols-only
  ];
 
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["chrisl"];
  users.groups.ubridge.members = ["chrisl"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];

  security.wrappers.ubridge = {
   source = "/run/current-system/sw/bin/ubridge";
   capabilities = "cap_net_admin,cap_net_raw=ep";
   owner = "root";
   group = "ubridge";
   permissions = "u+rx,g+x,o+rx";
   }; 
}
