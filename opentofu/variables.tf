variable "virtual_environment_endpoint" {
  type        = string
  description = "The endpoing for the Proxmox Virtual Environment API"
}

variable "virtual_environment_token" {
  type        = string
  sensitive   = true
  description = "The token for the Proxmox Virtual Environment API"
}