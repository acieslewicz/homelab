terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.101.1"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.16.0"
    }
  }
}