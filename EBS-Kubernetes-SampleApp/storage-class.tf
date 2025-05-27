resource "kubernetes_storage_class_v1" "storage_class" {
  metadata {
    name = "ebs-sc"
  }
  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "WaitForFirstConsumer"
  allow_volume_expansion = "true"
  reclaim_policy = "Retain"
}