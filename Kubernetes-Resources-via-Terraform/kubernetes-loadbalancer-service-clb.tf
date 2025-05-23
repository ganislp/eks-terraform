# resource "kubernetes_service_v1" "lb_service" {
#   metadata {
#     name = "finapp-lb-service"
#   }
#   spec {
#     selector = {
#       app = kubernetes_deployment_v1.fin_app_deployment.spec.0.selector.0.match_labels.app
#     }
#     port {
#       name        = "http"
#       port        = 80
#       target_port = 3000
#     }
#     type = "LoadBalancer"
#   }
# }