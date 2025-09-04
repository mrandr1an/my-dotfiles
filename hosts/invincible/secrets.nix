{ config, pkgs, ... }: {
  age.identityPaths = [ "/home/chrisl/.ssh/id_workstation" ];

  age.secrets.id_github_workstation = {
    file = ../../secrets/id_github_workstation.age;
    owner = "chrisl";
    mode = "0400";
    path = "/home/chrisl/.ssh/id_github_workstation";
  };

  age.secrets.id_github_workstation_pub = {
    file = ../../secrets/id_github_workstation_pub.age;
    owner = "chrisl";
    mode = "0400";
    path = "/home/chrisl/.ssh/id_github_workstation.pub";
  };
}
