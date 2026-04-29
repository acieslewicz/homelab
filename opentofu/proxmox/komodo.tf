resource "proxmox_virtual_environment_vm" "komodo_data" {
  node_name = "proxmox-01"
  started   = false
  on_boot   = false
  tags      = ["tofu", "data"]

  disk {
    datastore_id = "local-data"
    interface    = "scsi0"
    size         = 40
  }
}

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

  dynamic "disk" {
    for_each = { for idx, val in proxmox_virtual_environment_vm.komodo_data.disk : idx => val }
    iterator = data_disk

    content {
      datastore_id      = data_disk.value["datastore_id"]
      path_in_datastore = data_disk.value["path_in_datastore"]
      file_format       = data_disk.value["file_format"]
      size              = data_disk.value["size"]
      interface         = "scsi${data_disk.key + 1}"
    }
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