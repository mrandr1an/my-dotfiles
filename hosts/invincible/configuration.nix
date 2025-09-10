{config,pkgs,...} :
{
  imports =
    [
      ./hardware-configuration.nix
      ./network.nix
      ./locale.nix
      ./users.nix
      ./secrets.nix
      ./system.nix
      ./network.nix
      ./packages.nix
    ];

  programs.niri.enable = true; 
  hardware.opengl.enable = true;

  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "niri-session";  # provided by niri; sets up env + session properly
      user = "chrisl";
    };
  };

}
