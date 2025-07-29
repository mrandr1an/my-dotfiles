let
  github_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJrjbmxHd4yjq5Ge/vw3J1BYSjc9SngURx5a9kH+jGnW";
in
{
  "secret1.age".publicKeys = [ github_key ];
  "secret2.age".publicKeys = [ github_key ];
}

