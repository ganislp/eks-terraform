resource "kubernetes_deployment_v1" "mysql_deployment" {
  metadata {
    name = "mysql"
  }
  spec {
    replicas = 1
    strategy {
      type = "Recreate"
    }
    selector {
      match_labels = {
        app = "mysql"
      }
    }
    template {
      metadata {
       labels = {
          app = "mysql"
        }
      }
      spec {
         volume {
          name = "mysql-persistent-storage"
          persistent_volume_claim {
            claim_name = "ebs-mysql-pv-claim"
          }

        }
        volume {
          name = "usermanagement-dbcreation-script"
          config_map {
            name = "usermanagement-dbcreation-script"
          }
        }
        container {
          name              = "mysql"
          image             = "mysql:5.6"
          image_pull_policy = "Always"
          port {
            name           = "mysql"
            container_port = "3306"
          }
          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = "dbpassword11"
          }
          volume_mount {
            name       = "mysql-persistent-storage"
            mount_path = "/var/lib/mysql"
          }
          volume_mount {
            name       = "usermanagement-dbcreation-script"
            mount_path = "/docker-entrypoint-initdb.d"
          }

        }

      }
    }

  }
}