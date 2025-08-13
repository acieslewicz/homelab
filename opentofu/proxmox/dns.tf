resource "proxmox_virtual_environment_container" "dns1" {
  node_name = "proxmox-01"
  unprivileged = true

  tags = ["dns", "tofu", "ansible"]

  initialization {
    hostname = "dns-01"

    ip_config {
      ipv4 {
        address = "192.168.100.10/24"
        gateway = "192.168.100.1"
      }
    }

    dns {
        domain = "home.tinymagellanic.cloud"
        servers = ["9.9.9.9", "149.112.112.112"]
    }

    user_account {
      keys = [data.bitwarden_secret.homelab_public_ssh_key.value]
    }
  }

  network_interface {
    name = "veth0"
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.debian_bookworm_lxc.id
    type = "debian"
  }

  disk {
    datastore_id = "local-data"
    size = 20
  }

  features {
    nesting = true
  }
}