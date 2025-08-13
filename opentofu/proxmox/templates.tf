resource "proxmox_virtual_environment_download_file" "debian_bookworm_lxc" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = "proxmox-01"
  
  url          = "http://download.proxmox.com/images/system/debian-12-standard_12.7-1_amd64.tar.zst"
}