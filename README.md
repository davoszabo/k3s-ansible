# Automated build of HA k3s Cluster with `kube-vip`, basic `Traefik` ingress deployment, `Longhorn` and more.
🙌 This project was based on the following excellent repositories:
- [techno-tim/k3s-ansible](https://github.com/techno-tim/k3s-ansible)
- [sysengquick-yt/k3s](https://github.com/sysengquick-yt/k3s)

Huge thanks to them!

## 📖 Overview
Build a k3s Kubernetes cluster using Ansible. The goal here is to install a HA Kubernetes cluster easily with a base `Traefik` Ingress Controller with `cert-manager`, storage provisioning with `Longhorn`, and setting up SSO with `Authentik`. There are several other applications like `Nextcloud` on the list, and there will be even more to be integrated!

## ✅ System requirements
- Control (admin) node (the machine you are running `ansible` commands) must have Ansible 2.11+ If you need a quick primer on Ansible [you can check out my docs and setting up Ansible](https://technotim.live/posts/ansible-automation/).
- You will also need to install collections that this playbook uses by running `ansible-galaxy collection install -r ./collections/requirements.yml` (important❗)
- [`netaddr` package](https://pypi.org/project/netaddr/) must be available to Ansible. If you have installed Ansible via apt, this is already taken care of. If you have installed Ansible via `pip`, make sure to install `netaddr` into the respective virtual environment.
- `server` and `worker` nodes should have passwordless SSH access, if not you can supply arguments to provide credentials `--ask-pass --ask-become-pass` to each command.

> [!NOTE]  
> There will be a `.devcontainer` feature added to this repo to make the development environment uniform and portable.

## 🚀 Getting Started
The first and most important thing to start with is filling in the inventory itself and setting up the configurations correctly. The main starting point for the project was to have the whole cluster configuration in one file, so that everything could be configured from one place. Read the contents of the `inventory/template_cluster.yaml` file completely to understand what you might need and what not for your cluster. This will take approximately 30 minutes, but trust me, worth it!

### 🍴 Preparation (WIP)
Copy `inventory/template_cluster.yaml` and rename it to what ever you would like.
```
cp -R inventory/template_cluster.yaml inventory/my-cluster.yaml
```

Edit `inventory/my-cluster.yaml` to match the desired state of your system. There are hints and default values that might be helpful.

Rename `ansible.cfg.example` to `ansible.cfg` and adapt the inventory to match your inventory, etc.

### ☸️ Create Cluster
Start provisioning of the cluster using the following command:

> [!WARNING]
> The following steps might not work properly, because currently there are no deployment tests present that could identify errors due to new changes. The issue is being resolved soon!

```
ansible-playbook playbooks/k3s_install.yaml
```
After the deployment, the control plane will be accessible via virtual ip-address which is defined as **apiserver_endpoint**.

The installation will trigger basic ingress control setups (Traefik), and deploy the enabled applications.

### 🔥 Remove k3s cluster
```
ansible-playbook playbooks/k3s_unistall.yaml
```
You should also reboot these nodes due to the VIP not being destroyed!

## 🔨 Testing
`COMING SOON`
