variable "neo4j_url" {
  type = string
}

variable "neo4j_user" {
  type = string
}

variable "neo4j_password" {
  type = string
  sensitive = true
}

resource "kubernetes_secret" "neo4j_secret" {
  for_each = toset(local.namespaces)
  metadata {
    name      = "${each.key}-neo4j-secret"
    namespace = each.key
  }

  data = {
    url = var.neo4j_url
    username = var.neo4j_user
    password = var.neo4j_password
  }
}

resource "kubernetes_cron_job" "demo" {
  metadata {
    name = local.ping_neo4j
    namespace = "dev"
  }
  spec {
    failed_jobs_history_limit     = 5
    schedule                      = "0 6 */1 * *"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10
    job_template {
      metadata {}
      spec {
        backoff_limit              = 2
        template {
          metadata {}
          spec {
            container {
              name    = local.ping_neo4j
              image             = "08021986/${local.ping_neo4j}:v1"
              image_pull_policy = "Always"
              env {
                name = "NEO4J_URL"
                value_from {
                  secret_key_ref {
                    name = "dev-neo4j-secret"
                    key  = "url"
                  }
                }
              }
              env {
                name = "NEO4J_USER"
                value_from {
                  secret_key_ref {
                    name = "dev-neo4j-secret"
                    key  = "username"
                  }
                }
              }
              env {
                name = "NEO4J_PASSWORD"
                value_from {
                  secret_key_ref {
                    name = "dev-neo4j-secret"
                    key  = "password"
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}