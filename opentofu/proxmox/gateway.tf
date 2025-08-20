resource "proxmox_virtual_environment_vm" "gateway" {
  name      = "gateway"
  node_name = "proxmox-01"
  tags      = ["tofu", "ansible", "docker", "periphery"]

  clone {
    vm_id = proxmox_virtual_environment_vm.debian_template.id
  }

  agent {
    enabled = true
  }

  initialization {
    dns {
      servers = ["9.9.9.9", "149.112.112.112"]
    }
    ip_config {
      ipv4 {
        address = "192.168.100.50/24"
        gateway = "192.168.100.1"
      }
    }
  }
}