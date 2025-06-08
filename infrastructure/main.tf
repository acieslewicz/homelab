data "local_file" "ssh_public_key" {
  filename = "./homelab_ed25519.pub"
}

resource "proxmox_virtual_environment_download_file" "latest_debian_12_bookworm_lxc_img" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "proxmox-01"
  url          = "http://download.proxmox.com/images/system/debian-12-standard_12.7-1_amd64.tar.zst"
}

resource "proxmox_virtual_environment_container" "dns1" {

  node_name    = "proxmox-01"
  unprivileged = true

  tags = ["dns"]

  initialization {
    hostname = "dns-01"

    ip_config {
      ipv4 {
        address = "192.168.100.10/24"
        gateway = "192.168.100.1"
      }
    }

    dns {
      domain  = "home.tinymagellanic.cloud"
      servers = ["9.9.9.9", "149.112.112.112"]
    }

    user_account {
      keys = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }

  network_interface {
    name = "veth0"
  }


  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.latest_debian_12_bookworm_lxc_img.id
    type             = "debian"
  }

  disk {
    datastore_id = "local-lvm"
    size         = 20
  }

  features {
    nesting = true
  }
}

resource "proxmox_virtual_environment_container" "proxy1" {

  node_name    = "proxmox-01"
  unprivileged = true

  tags = ["proxy"]

  initialization {
    hostname = "proxy-01"

    ip_config {
      ipv4 {
        address = "192.168.100.20/24"
        gateway = "192.168.100.1"
      }
    }

    user_account {
      keys = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }

  network_interface {
    name = "veth0"
  }


  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.latest_debian_12_bookworm_lxc_img.id
    type             = "debian"
  }

  disk {
    datastore_id = "local-lvm"
    size         = 20
  }

  features {
    nesting = true
  }
}

resource "proxmox_virtual_environment_container" "tunnel1" {

  node_name    = "proxmox-01"
  unprivileged = true

  tags = ["tunnel"]

  initialization {
    hostname = "clouflare-tunnel-01"

    ip_config {
      ipv4 {
        address = "192.168.110.10/24"
        gateway = "192.168.110.1"
      }
    }

    user_account {
      keys = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }

  network_interface {
    name    = "veth0"
    vlan_id = 110
  }


  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.latest_debian_12_bookworm_lxc_img.id
    type             = "debian"
  }

  disk {
    datastore_id = "local-lvm"
    size         = 20
  }

  features {
    nesting = true
  }
}

resource "proxmox_virtual_environment_container" "proxy2" {

  node_name    = "proxmox-01"
  unprivileged = true

  tags = ["proxy"]

  initialization {
    hostname = "external-proxy-001"

    ip_config {
      ipv4 {
        address = "192.168.110.30/24"
        gateway = "192.168.110.1"
      }
    }

    user_account {
      keys = [trimspace(data.local_file.ssh_public_key.content)]
    }
  }

  network_interface {
    name    = "veth0"
    vlan_id = 110
  }

  operating_system {
    template_file_id = proxmox_virtual_environment_download_file.latest_debian_12_bookworm_lxc_img.id
    type             = "debian"
  }

  disk {
    datastore_id = "local-lvm"
    size         = 20
  }

  features {
    nesting = true
  }
}