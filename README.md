# RKE cluster terraform module 

Terraform module for installing RKE cluster. 

Module will do following tasks:
- Connect to configured nodes
- Install RKE cluster

## Variables

### Input

This module accept the following variables as input:

```
# Required variables
variable "rke_nodes" {
  type = list(object({
    public_ip = string
    private_ip = string
    hostname = string
    roles = list(string)
    user = string
    ssh_key = string
  }))
  description = "Node info to install RKE cluster"
}

# Optional variables
variable "rke" {
  default = {
    cluster_name = "rancher-server"
    kubernetes_version = "" 
  }
  description = "RKE configuration"
}
```

### Output

This module use the following variables as ouput:

```
output "kubeconfig_api_server_url" {
  value = rke_cluster.rancher_cluster.api_server_url
}

output "kubeconfig_client_cert" {
  value = rke_cluster.rancher_cluster.client_cert
  sensitive = true
}

output "kubeconfig_client_key" {
  value = rke_cluster.rancher_cluster.client_key
  sensitive = true
}

output "kubeconfig_ca_crt" {
  value = rke_cluster.rancher_cluster.ca_crt
  sensitive = true
}

output "kubeconfig_yaml" {
  value = rke_cluster.rancher_cluster.kube_config_yaml
  sensitive = true
}
```

## How to use

This tf module can be used standalone or combined with other tf modules.

Requirements for use standalone:
* Nodes up and running folowing https://rancher.com/docs/rke/latest/en/os/
* Input node info on rke_nodes variable

Add the following to your tf file:

```
module "rke-cluster" {
  source = "github.com/rawmind0/tf-module-rke-cluster"

  rancher_nodes = module.rancher_infra.aws_nodes

  rke = {
    cluster_name = local.name
    kubernetes_version = local.kubernetes_version
  }
}
```

