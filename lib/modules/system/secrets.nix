#lib/modules/system/secrets.nix
{config,lib,archetype,...}:
let
  cfg = config.syssecrets;
in
{
  options.syssecrets = {
    privateKeyPaths = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "/home/${archetype.user}/.ssh/id_workstation" ];
    };
  };

  config = {
    age.identityPaths = cfg.privateKeyPaths;

    age.secrets.id_github_workstation = {
      file = ../../../secrets/id_github_workstation.age;
      owner = "chrisl";
      mode = "0400";
      path = "/home/chrisl/.ssh/id_github_workstation";
    };

    age.secrets.id_github_workstation_pub = {
      file = ../../../secrets/id_github_workstation_pub.age;
      owner = "chrisl";
      mode = "0400";
      path = "/home/chrisl/.ssh/id_github_workstation.pub";
    };

    age.secrets.chrisl_password = {
      file = ../../../secrets/chrisl_password.age;
      owner = "chrisl";
      mode = "0400";
    };
  };
  
}
