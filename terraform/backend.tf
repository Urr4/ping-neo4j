terraform {
  backend "kubernetes" {
    secret_suffix = "ping-neo4j"
    config_path   = "~/.kube/config"
  }
}