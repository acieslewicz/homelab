resource "proxmox_virtual_environment_file" "cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "proxmox-01"

  source_raw {
    data = <<-EOF
    #cloud-config
    timezone: America/Denver
    ssh_pwauth: false
    disable_root: true
    groups:
      - docker: [989]
    users:
      - name: administrator
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${data.bitwarden_secret.homelab_public_ssh_key.value}
        sudo: ALL=(ALL) NOPASSWD:ALL
    package_update: true
    packages:
      - qemu-guest-agent
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "cloud-config.yaml"
  }
}
