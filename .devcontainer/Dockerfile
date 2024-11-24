FROM mcr.microsoft.com/devcontainers/python:3.12-bookworm

# Install Ansible essentials and dev tools
ARG ANSIBLE_VERSION="10.6.0"
RUN pip install ansible==${ANSIBLE_VERSION}

ARG ANSIBLE_DEV_TOOLS_VERSION="24.10.2"
RUN pip install ansible-dev-tools==${ANSIBLE_DEV_TOOLS_VERSION}

ARG KUBERNETES_VERSION="31.0.0"
RUN pip install kubernetes==${KUBERNETES_VERSION}

# Install netaddr
ARG NETADDR_VERSION="1.3.0"
RUN pip install netaddr==${NETADDR_VERSION}

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/

# Install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
    && chmod 700 get_helm.sh \
    && ./get_helm.sh

# Install Terraform
ARG TERRAFORM_VERSION="1.9.8"
RUN curl -LO "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
    && unzip terraform_*.zip \
    && mv terraform /usr/local/bin/ \
    && rm -rf terraform_*.zip

# Install extras for Terraform and ansible
ARG JMESPATH_VERSION="1.0.1"
RUN pip install jmespath==${JMESPATH_VERSION}

