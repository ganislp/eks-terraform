resource "kubernetes_deployment_v1" "usermgmt_webapp_deployment" {
    depends_on = [ kubernetes_deployment_v1.mysql_deployment ]
  metadata {
    name = "usermgmt-webapp"
    labels = {
      "app" = "usermgmt-webapp"
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        "app" = "usermgmt-webapp"
      }
    }
    template {
        metadata {
          name = "usermgmt-webapp"
        }
      spec {

        container {
          name = "usermgmt-webapp-container"
          image = ""
          image_pull_policy = "Always"
          port {
            container_port = "8080"
          }
          env {
            name =  "DB_HOSTNAME"
            value = kubernetes_service_v1.mysql_cluster_service.metadata.0.name
          }
          env {
            name =  "DB_PORT"
            value = kubernetes_service_v1.mysql_cluster_service.spec.0.port.0.port
          }
          env {
            name = "DB_NAME"
            value = "webappdb"
          }
          env {
            name = "DB_USERNAME"
            value = "root"
          }
          env {
            name = "DB_PASSWORD"
            value = "dbpassword11"
          }
        }
      }
    }
  }
}