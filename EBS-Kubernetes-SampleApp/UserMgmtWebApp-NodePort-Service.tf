resource "kubernetes_service_v1" "node_port_service" {
  metadata {
    name = "usermgmt-webapp-nodeport-service"
  }
  spec {
    selector = {
      "app" = kubernetes_deployment_v1.usermgmt_webapp_deployment.spec.0.selector.0.match_labels.app
    }
    port {
      name        = "http"
      target_port = "8080"
      port        = "80"
      node_port   = "31280"
    }
    type = "NodePort"
  }
}