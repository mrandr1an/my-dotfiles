{
  arch = "x86-64-linux";
  
  user = "chrisl";
  
  desktop-environment = {
    enable = true;
    
    window-manager = {
      enable = true;
      niri = {
        enable = true;
      };
    };

    display-manager = {
      enable = true;
      regreet = {
        enable = true;
      };
    };
  };

  workstation = {
    enable = true;
  };
}
