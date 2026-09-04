terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.112.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.17.6"
    }
  }
}