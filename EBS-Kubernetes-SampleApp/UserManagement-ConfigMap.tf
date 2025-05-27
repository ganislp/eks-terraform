resource "kubernetes_config_map_v1" "usermanagement_dbcreation_script" {
  metadata {
    name = "usermanagement-dbcreation-script"
  }
  data = {
    "webappdb.sql" = "${file("${path.module}/webappdb.sql")}"
  }
}