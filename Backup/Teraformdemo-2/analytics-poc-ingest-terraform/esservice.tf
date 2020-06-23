resource "ibm_resource_instance" "event-stream-demo" {
  name              = "${var.team}-${var.service}-${var.paln-type}-${var.work}"
  service           = "messagehub"
  plan              = "${var.event_stream_plan}"
  location          = "${var.event_stream_location}"
  resource_group_id = "${data.ibm_resource_group.resource-group.id}"

  tags = [
    "cloud-platform  = ${var.cloud-platform}",
    "billing         = ${var.billing}",
    "customer-id     = ${var.customer-id}",
    "org-department  = ${var.org-department}",
    "org-environment = ${var.org-environment}",
    "Component       = ${var.Component}",
    "es-name         = ${var.es-name}",
    "owner           = ${var.owner}",
    "alert-severity  = ${var.alert-severity}",
    "contact         = ${var.contact}",
  ]

  parameters = {
    "HMAC" = true
  }

  //User can increase timeouts
  timeouts {
    create = "150m"
    update = "90m"
    delete = "90m"
  }
}

resource "ibm_resource_key" "EvenSt-resourceKey" {
  name                 = "${var.team}-${var.service}-${var.work}-${var.key_name}"
  role                 = "${var.role}"
  resource_instance_id = "${ibm_resource_instance.event-stream-demo.id}"
}

resource "ibm_container_bind_service" "EvenSt-iks-bind" {
  cluster_name_id     = "${ibm_container_cluster.iks-cluster-demo.id}"
  space_guid          = "${data.ibm_space.space.id}"
  service_instance_id = "${ibm_resource_instance.event-stream-demo.name}"
  namespace_id        = "default"
  org_guid            = "${data.ibm_org.org.id}"
  resource_group_id   = "${data.ibm_resource_group.resource-group.id}"
  key                 = "${var.team}-${var.service}-${var.work}-${var.key_name}"
  role                = "${var.role}"
}
