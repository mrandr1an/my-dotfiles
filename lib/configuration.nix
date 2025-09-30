#lib/configuration.nix
{config,lib,archetype,...}:
let
  inherit (lib) optionals;
  isWorkstation = if archetype.workstation != null
                  then
                    true
                  else
                    false;
  isVirtualMachine = if archetype.virtual-machine != null
                     then
                       true
                     else
                       false; 
  vmOrWs = vmMod: wsMod:
    if isWorkstation
    then 
      wsMod
    else if isVirtualMachine
    then
      vmMod
    else
      throw "A host must either be a virtual-machine or a workstation."; 
in
{
  imports = [
              ./modules/system/hardware.nix
              ./modules/system/software.nix
              ./modules/system/home.nix
              ./modules/system/secrets.nix
            ];

  config =
    let
      hwConfig = vmOrWs
        {
          syshardware = {
            qemu = {
              enable = true;
              arch = archetype.arch;
              guest = true;
            };
          };
        }
        {
          syshardware = {
            physical = {
              enable = true;
              arch = archetype.arch; 
            };
          };
        };
      sysConfig = vmOrWs
        {
          syssoftware = {
            network = {
              hostname = archetype.hostname;
            };
            ssh.enable = true;
          };
        }
        {
          syssoftware = {
            network = {
              hostname = archetype.hostname;
            };
            audio.enable = true;
            bluetooth.enable = true;
          };
        };
      homeConfig = vmOrWs
        {
          syshome = {
            username = "chrisl";
          };
        }
        {
          syshome = {
            username = "chrisl";
          };
        };
      secretsConfig = vmOrWs
        {
          secrets = {
            privateKeyPaths = [  "/home/chrisl/.ssh/id_workstation" ];
          };
        }
        {
          secrets = {
            privateKeyPaths = [  "/home/chrisl/.ssh/id_workstation" ];
          };
        };
    in
      lib.mkMerge [
        hwConfig
        sysConfig
        homeConfig
        secretsConfig
      ];
}
