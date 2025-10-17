terraform {
  required_version = ">=1.5.0"
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = ">=0.84.1"
    }
  }
}

provider "proxmox" {
 endpoint = "https://192.168.2.15:8006/api2/json"
 api_token = "terraform@pve!terraform=5cd9875c-7d32-4f95-9895-6bcab3d36ce0"
 insecure = true
}

resource "proxmox_virtual_environment_vm" "nixos" {
  node_name = "vengeance"
  vm_id = 500
  name = "terraformTest"
  bios = "ovmf"
  machine     = "q35"

  memory {
    dedicated = 8048
  }

  clone {
    vm_id = 901
    full  = true
  }

  vga {
    type   = "virtio-gl"  
    memory = 512          
  }
  
  agent {
    enabled = true
  }
}

locals {
  ipv4 = "192.168.2.20"
}

module "deploy" {
  depends_on = [
    proxmox_virtual_environment_vm.nixos
  ]
  source                 = "github.com/nix-community/nixos-anywhere//terraform/all-in-one"
  nixos_system_attr      = ".#nixosConfigurations.invincible.config.system.build.toplevel"
  nixos_partitioner_attr = ".#nixosConfigurations.invincible.config.system.build.diskoScript"
  extra_files_script     = "${path.module}/secrets.sh"
  disk_encryption_key_scripts = [{
    path   = "/tmp/disk-1.key"
    script = "${path.module}/disk.sh"
  }]
  install_user = "root"
  install_ssh_key = <<EOF
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACC2DJ2TDI6jcIqHVEAUOpvR6TSBYW/JXKCQ5mFCYspjpwAAAJgXQmFTF0Jh
UwAAAAtzc2gtZWQyNTUxOQAAACC2DJ2TDI6jcIqHVEAUOpvR6TSBYW/JXKCQ5mFCYspjpw
AAAEDXrw/AkLhPQkr21apkZylBGiId/4clHhqHGyQ53sRfabYMnZMMjqNwiodUQBQ6m9Hp
NIFhb8lcoJDmYUJiymOnAAAAEWNocmlzbEBpbnZpbmNpYmxlAQIDBA==
-----END OPENSSH PRIVATE KEY-----
EOF
  install_port           = 22                                    
  target_host            = local.ipv4
  instance_id            = local.ipv4
  kexec_tarball_url      =  "http://192.168.2.15:8000/nixos-kexec-installer-noninteractive-x86_64-linux.tar.gz"
  phases = [
    "kexec", "disko",
    "install",
  ]
}
