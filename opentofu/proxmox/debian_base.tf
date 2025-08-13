resource "proxmox_virtual_environment_vm" "debian_template" {
  name      = "debian-template"
  node_name = "proxmox-01"
  tags      = ["tofu"]

  template = true
  started  = false

  machine = "q35"
  bios    = "ovmf"

  cpu {
    cores = 2
    type  = "host"
  }

  memory {
    dedicated = 2048
  }

  efi_disk {
    datastore_id = "local-data"
    type         = "4m"
  }

  network_device {
    bridge = "vmbr0"
  }

  disk {
    datastore_id = "local-data"
    file_id      = proxmox_virtual_environment_download_file.debian_trixie_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 20
  }

  initialization {
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }
}