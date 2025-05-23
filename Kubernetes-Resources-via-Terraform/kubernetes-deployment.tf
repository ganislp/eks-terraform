resource "kubernetes_deployment_v1" "fin_app_deployment" {
  metadata {
    name = "finapp-deployment"
    labels = {
      app = "finApp"
    }
  }
  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "finapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "finapp"
        }
      }

      spec {
        container {
          image = "466649784722.dkr.ecr.us-east-1.amazonaws.com/frc-app"
          name  = "finapp-container"
          port {
            container_port = 3000
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "0.5"
              memory = "512Mi"
            }
          }
        }
        
      }
    }
  }
}