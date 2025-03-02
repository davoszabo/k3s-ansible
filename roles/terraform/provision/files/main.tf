resource "proxmox_vm_qemu" "k3s_node" {
    for_each        = { for node in var.nodes : node.name => node }
    name            = "${each.value.name}"
    target_node     = var.proxmox_target_node
    vmid            = var.vmid + index(var.nodes, each.value)
    clone           = var.template_name
    full_clone      = "true"
    cpu             = var.cpu_type
    cores           = var.vm_cores
    memory          = var.vm_memory
    os_type         = "cloud-init"
    boot            = "order=scsi0"
    scsihw          = "virtio-scsi-pci"

    # Cloud-Init configuration
    ipconfig0       = "ip=${each.value.ip}/24,gw=${var.gateway}"
    ciupgrade       = true
    ciuser          = var.ciuser
    cipassword      = var.cipassword
    sshkeys         = var.ssh_public_key

    serial {
        id = 0
        type = "socket"
    }

    disks {
        ide {
            ide2 {
                cloudinit {
                    storage     = var.storage_pool
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    storage     = var.storage_pool
                    size        = var.storage_size
                    cache       = "none"
                    backup      = true
                    discard     = false
                    iothread    = false
                }
            }
        }
    }

    network {
        bridge = "vmbr0"
        model  = "virtio"
    }
}


