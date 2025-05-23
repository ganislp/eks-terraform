resource "kubernetes_service_v1" "nlb_service" {
  metadata {
    name = "fin-app-nlb-service"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.fin_app_deployment.spec.0.selector.0.match_labels.app
    }
    port {
      name        = "http"
      port        = 80
      target_port = 3000
    }
    type = "LoadBalancer"
  }
}