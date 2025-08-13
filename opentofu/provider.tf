terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.81.0"
    }
    bitwarden = {
      source  = "maxlaverse/bitwarden"
      version = "0.15.0"
    }
  }
}

provider "bitwarden" {
  access_token = var.bws_access_token
  experimental {
    embedded_client = true
  }
}

provider "proxmox" {
  endpoint  = data.bitwarden_secret.proxmox_endpoint.value
  api_token = data.bitwarden_secret.proxmox_access_token.value


  ssh {
    // TODO: Move away from root
    username = "root"

    agent = false
  }
}