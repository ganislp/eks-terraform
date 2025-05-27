resource "kubernetes_service_v1" "lb_service" {
  metadata {
    name = "usermgmt-webapp-lb-service"
    annotations = {
        "service.beta.kubernetes.io/aws-load-balancer-type": "nlb"
    }
  }
  spec {
    selector = {
      "app" = kubernetes_deployment_v1.usermgmt_webapp_deployment.spec.0.selector.0.match_labels.app
    }
    port {
      target_port = "8080"
      port = "80"
    }
    type = "LoadBalancer"
  }
}