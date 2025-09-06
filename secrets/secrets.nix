let
  workstation_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJrjbmxHd4yjq5Ge/vw3J1BYSjc9SngURx5a9kH+jGnW";
  laptop_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMjdsvQ5Bd0kXFAjVhD/VY1vi/fFERnUYHo6U7DcN4RX"; 
in
{
  "id_github_laptop.age".publicKeys = [ laptop_key ];
  "id_github_laptop_pub.age".publicKeys = [ laptop_key ];
  "id_github_workstation.age".publicKeys = [ workstation_key ];
  "id_github_workstation_pub.age".publicKeys = [ workstation_key ];
  "email_password.age".publicKeys = [ workstation_key ];
}
