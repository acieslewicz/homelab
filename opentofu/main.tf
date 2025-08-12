terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket                      = "homelab-configuration"
    key                         = "tf.tfstate"
    region                      = "us-east-va"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    endpoints = {
      s3 = var.s3_endpoint
    }
  }
}

module "proxmox" {
  source = "./proxmox"

  providers = {
    proxmox = proxmox
  }
}