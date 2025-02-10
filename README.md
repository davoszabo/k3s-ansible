# Automated install of HA k3s cluster
The Kubernetes cluster consists of `kube-vip`, basic `Traefik` ingress deployment, `Authentik` identity provider, `Longhorn` and many more!

🙌 This project was based on the following excellent repositories:
- [techno-tim/k3s-ansible](https://github.com/techno-tim/k3s-ansible)
- [sysengquick-yt/k3s](https://github.com/sysengquick-yt/k3s)

Huge thanks to them!

## 📖 Overview
Build a k3s Kubernetes cluster using Ansible and Terraform. The goal here is to install a HA Kubernetes cluster easily with a base `Traefik` Ingress Controller with `cert-manager`, storage provisioning with `Longhorn`, and setting up SSO with `Authentik`. There are several other applications like `Nextcloud` on the list, and there will be even more to be integrated! Check full list under `roles/kubernetes/`!

## ✅ Requirements
The project description does not contain section for setting up the development environment. The recommended way is to use the devcontainer feature, either the `VS Code extension` or `devcontainer-cli`. The Dockerfile for the development image contains the required packages inside `.devcontainer/` if you want to install them manually.

`server` and `worker` nodes should have passwordless SSH access, if not you can supply arguments to provide credentials `--ask-pass --ask-become-pass` to each command.

### Terraform setup
It is possible to use Terraform to create VMs for the k3s cluster. You need to install Terraform on your system or use the devcontainer feature. To use it in a playbook, add this collection: `community.general.terraform`, but it is already specified inside the `collections/requirements.yml`. The supported providers are:

- Proxmox (cloud-init)

## 🚀 Getting Started
The first and most important thing to start with is filling in the inventory itself and setting up the configurations correctly. The main starting point for the project was to have the whole cluster configuration in one file, so that everything could be configured from one place. Read the contents of the `inventory/template_cluster.yaml` file completely to understand what you might need and what not for your cluster. This will take approximately 30 minutes, but trust me, worth it!

### 🍴 Preparation (WIP)
Copy `inventory/template_cluster.yaml` and rename it to what ever you would like.
```
cp -R inventory/template_cluster.yaml inventory/my-cluster.yaml
```

Edit `inventory/my-cluster.yaml` to match the desired state of your system. There are hints and default values that might be helpful.

Rename `ansible.cfg.example` to `ansible.cfg` and adapt the settings to match your inventory, etc.

### ☸️ Create Cluster
Start provisioning of the cluster using the following command:

> [!WARNING]
> The following steps might not work properly, because currently there are no deployment tests present that could identify errors due to new changes. The issue is being resolved soon!

Use the `--check` flag to test the configuration before applying it to the cluster! This is true for every `ansible-playbook` command!

If you don't want setup VMs manually on your server and curios about auto-provisioning VMs with Terraform, go ahead and try this:
```
ansible-playbook playbooks/terraform-provision.yaml
```

Install k3s cluster on the servers:
```
ansible-playbook playbooks/k3s_install.yaml
```

After the deployment, the control plane will be accessible via virtual ip-address which is defined as **apiserver_endpoint**.


Set up basic ingress:
```
ansible-playbook playbooks/base_ingress.yaml
```

> [!NOTE]
> You can use tags to apply only what you need. Please check the playbook files for supported tags.
> ```
> ansible-playbook playbooks/base_ingress.yaml -t cert-manager
> ```

Set up storage provisioning with `Longhorn`:
```
ansible-playbook playbooks/base_storage.yaml
```

Set up applications like `Authentik` or `Nextcloud`. You need to set the `enabled: true` for each application that you would like to use in your `inventory/my-cluster` file under the `kubernetes` section.
```
ansible-playbook playbooks/base_apps.yaml -t authentik
```

### 🔥 Remove k3s cluster
```
ansible-playbook playbooks/k3s_unistall.yaml
```
You should also reboot these nodes due to the VIP not being destroyed!

## 🔨 Testing
`COMING SOON`
