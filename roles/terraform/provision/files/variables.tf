# variables.tf

variable "proxmox_api_url" {
  description = "The API URL for the Proxmox server."
  type        = string
}

variable "proxmox_api_token_id" {
  description = "The Proxmox API token ID."
  type        = string
}

variable "proxmox_api_token_secret" {
  description = "The Proxmox API token secret."
  type        = string
}

variable "proxmox_target_node" {
  description = "The Proxmox target node name where VMs will be created."
  type        = string
}

variable "vmid" {
  description = "The ID of the VM in Proxmox. The default value of 0 indicates it should use the next available ID in the sequence."
  type        = number
  default     = 0
}

variable "template_name" {
  description = "The name of the VM template in Proxmox."
  type        = string
}

variable "gateway" {
  description = "The network gateway for the VM."
  type        = string
}

variable "vm_cores" {
  description = "Number of CPU cores for the VM."
  type        = number
  default     = 2  # Optional default value
}

variable "vm_memory" {
  description = "Memory allocated to the VM in MB."
  type        = number
  default     = 2048  # Optional default value
}

variable "ciuser" {
  description = "Override the default cloud-init user for provisioning."
  type        = string
}

variable "cipassword" {
  description = "Override the default cloud-init user's password. Sensitive."
  type        = string
}

variable "ssh_public_key" {
  description = "The SSH public key to insert into the VM."
  type        = string
}

variable "name_prefix" {
  description = "Prefix for naming server nodes in the cluster."
  type        = string
  default     = "k3s-default"  # Optional default value
}

variable "storage_pool" {
  description = "The pool used for VM disk space"
  type        = string
  default     = "local"  # Optional default value
}

variable "storage_size" {
  description = "The storage size used for VM boot disk"
  type        = string
  default     = "5G"  # Optional default value
}

variable "nodes" {
  description = "List of k3s nodes with IPs and type tags"
  type = list(object({
    name = string
    ip   = string
    type = string  # Either 'server' or 'worker'
  }))
}

