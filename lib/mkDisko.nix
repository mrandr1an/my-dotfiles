#lib/mkDisko.nix
{archetype}:
{lib}:
let
  disks = archetype.disks or {};
  disksList = lib.mapAttrsToList (deviceName: deviceValue: {
    name = deviceName;
    value = {
        device = "/dev/disk/by-id/${deviceValue.id}";
        type = "disk";
        content = deviceValue.content;
    };
  }) disks;
  devices = builtins.listToAttrs disksList;
in
{
  disko = {
    devices.disk = devices;
    enableConfig = true;
  };
}
