resource "ibm_resource_instance" "cose-testing-dal" {
  name              = "cos-tera-testing-dal12"
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
//  resource_group_id = "c66327a3523043c39a6411a787915d5a "

//  tags = [
//    "cloud-platform  = ${var.cloud-platform}",
//    "billing         = ${var.billing}",
//    "customer-id     = ${var.customer-id}",
//    "org-department  = ${var.org-department}",
//    "org-environment = ${var.org-environment}",
//    "cos-name        = ${var.cos-name}",
//    "owner           = ${var.owner}",
//    "alert-severity  = ${var.alert-severity}",
//    "contact         = ${var.contact}",
//  ]

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

// resource "ibm_resource_key" "cos-resource-key" {
//  name                 = "${var.team}${var.service}-${var.storage}-${var.work}-${var.key_name}"
//  role                 = "${var.role}"
//  resource_instance_id = "${ibm_resource_instance.cos-resource-instance-demo.id}"

//  parameters = {
//    "HMAC" = true
//  }
// }

output "resource_id" {
  value = "${ibm_resource_instance.cose-testing-dal.id}"
}

// resource "ibm_container_bind_service" "objectstorage-iks-bind" {
//  cluster_name_id     = "${ibm_container_cluster.iks-cluster-demo.id}"
//  space_guid          = "${data.ibm_space.space.id}"
//  service_instance_id = "${ibm_resource_instance.cos-resource-instance-demo.name}"
//  namespace_id        = "default"
//  org_guid            = "${data.ibm_org.org.id}"
//  resource_group_id   = "${data.ibm_resource_group.resource-group.id}"
//  key                 = "${var.team}-${var.service}-${var.storage}-${var.work}-${var.key_name}"
//  role                = "${var.role}"
//}
// ================== variable =========================

