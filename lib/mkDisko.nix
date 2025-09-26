#lib/mkDisko.nix
{archetype}:
{lib}:
let
  disks = archetype.disks;
  numberOfDisks = builtins.length disks; 
  bootDisks = builtins.filter
    (disk: builtins.hasAttr "boot" disks.partitions)
     (builtins.attrValues disks);
  rootDisks = builtins.filter
    (disk: builtins.hasAttr "root" disks.partitions)
     (builtins.attrValues disks);
  homeDisks = builtins.filter
    (disk: builtins.hasAttr "home" disks.partitions)
     (builtins.attrValues disks);
in
{
  assertions  = [
    {
      assertion = ((builtins.length bootDisks) == 1);
      message = "There can only be one boot partition";
    }

    {
      assertion = ((builtins.length rootDisks) == 1);
      message = "There can only be one root partition";
    }

    {
      assertion = ((builtins.length homeDisks) == 1);
      message = "There can only be one home partition";
    }
  ];

  a = bootDisks;
}
