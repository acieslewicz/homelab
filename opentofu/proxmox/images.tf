resource "proxmox_virtual_environment_download_file" "debian_trixie_cloud_image" {
  content_type = "import"
  datastore_id = "local"
  node_name    = "proxmox-01"

  url = "https://cloud.debian.org/images/cloud/trixie/latest/debian-13-genericcloud-amd64.qcow2"
}