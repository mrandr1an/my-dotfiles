let
  github_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGoKhCdznE9c0CgZ1QBib6qP4tPc3tuDz+2CJjx9vNOP krackedissad@gmail.com";
in
 {
  "secret1.age".publicKeys = [github_key];
  "secret2.age".publicKeys = [github_key];
 }
