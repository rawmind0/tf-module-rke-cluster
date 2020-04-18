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

variable "rke" {
  type = object({
    cluster_name = string
    kubernetes_version = string
  })
  default = {
    cluster_name = "rancher-server"
    kubernetes_version = ""
  }
  description = "RKE configuration"
}