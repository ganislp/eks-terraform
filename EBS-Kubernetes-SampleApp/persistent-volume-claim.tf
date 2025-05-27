resource "kubernetes_persistent_volume_claim_v1" "ebs_mysql_pv_claim" {
  metadata {
    name = "ebs-mysql-pv-claim"
  }
  spec {
    access_modes = [ "ReadWriteOnce" ]
    storage_class_name = kubernetes_storage_class_v1.storage_class.metadata.0.name
    resources {
      requests = "4Gi"
    }
  }
}