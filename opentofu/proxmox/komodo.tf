resource "proxmox_virtual_environment_vm" "komodo" {
  name      = "komodo"
  node_name = "proxmox-01"
  tags      = ["tofu", "ansible", "docker", "komodo"]

  clone {
    vm_id = proxmox_virtual_environment_vm.debian_template.id
  }

  agent {
    enabled = true
  }

  memory {
    dedicated = 4096
  }

  disk {
    datastore_id = "local-data"
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 40
  }

  initialization {
    dns {
      domain  = "home.tinymagellanic.cloud"
      servers = ["9.9.9.9", "149.112.112.112"]
    }
    ip_config {
      ipv4 {
        address = "192.168.100.60/24"
        gateway = "192.168.100.1"
      }
    }
  }
}