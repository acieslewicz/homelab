# Homelab Configuration

My homelab configuration files using opentofu and ansible. Services are deployed on proxmox.

## Proxmox Configuration

- Install proxmox and copy over an ssh managment key:
```bash
ssh-copy-id -i {ssh_key_id} {user}@{hypervisor-ip}
```

- Run the community post pve install script:
```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/tools/pve/post-pve-install.sh)"
```

- [Setup an management user](https://registry.terraform.io/providers/bpg/proxmox/latest/docs#authentication)

```bash
sudo pveum user add opentofu@pve
```
```bash
sudo pveum role add Opentofu -privs "Datastore.AllocateTemplate Datastore.Audit Sys.Audit Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options"
```

```bash
sudo pveum aclmod / -user opentofu@pve -role Opentofu
```

```bash
sudo pveum user token add opentofu@pve provider --privsep=0
```

- [Configure ACME](https://pve.proxmox.com/wiki/Certificate_Management)

