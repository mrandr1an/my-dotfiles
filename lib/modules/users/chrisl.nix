#lib/modules/users/chrisl.nix
{config,...}:
{
  users.users.chrisl = {
    isNormalUser = true;
    hashedPasswordFile = config.age.secrets.chrisl_password.path;
    extraGroups = [ "wheel" "networkmanager" ]; 
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.users.chrisl = import ../../../hm/users/chrisl.nix;
  home-manager.extraSpecialArgs = {
    desktopChoices = {
      niri = true;
    };
  };
}
