resource "kubernetes_job_v1" "irsa_demo" {
  metadata {
    name = "irsa-demo"
  }

  spec {
    template {
      metadata {
        labels = {
          "app" = "irsa-demo"
        }
      }
      spec {
        service_account_name = kubernetes_service_account_v1.irsa_demo_sa.metadata.0.name
        container {
          name  = "irsa-demo"
          image = "amazon/aws-cli:latest"
          args  = ["s3", "ls"]


          resources {
            limits = {
              cpu    = "0.5"
              memory = "250Mi"
            }
            requests = {
              cpu    = "0.5"
              memory = "250Mi"
            }
          }
        }

        restart_policy = "Never"
      }
    }
  }
  wait_for_completion = false
}