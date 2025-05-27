resource "kubernetes_service_v1" "mysql_cluster_service" {
  metadata {
    name = "mysql"
  }
  spec {
    selector = {
      "app" = "mysql"
    }
    port {
      port = "3306"

    }
    cluster_ip = "None"
    type       = "ClusterIP"
  }
}