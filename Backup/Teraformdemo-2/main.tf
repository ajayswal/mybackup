// Define datasource for organisation
data "ibm_org" "org" {
  org = "${var.org}"
}

// Define datasource for CF space
data "ibm_space" "space" {
  org   = "${var.org}"
  space = "${var.space}"
}

// Here we assume that resource group is created externally and already exists
data "ibm_resource_group" "resource-group" {
  name = "${var.group}"
}

resource "ibm_network_vlan" "private" {
  count = "${length(var.zones)}"

  name            = "af-demo-${var.zones[count.index]}"
  datacenter      = "${var.zones[count.index]}"
  type            = "PRIVATE"
  router_hostname = "${lookup(var.zone_router_map_private, "${var.zones[count.index]}")}"
  timeouts {
    create = "25m"
    delete = "30m"
  }
   
}

resource "ibm_network_vlan" "public" {
  count = "${length(var.zones)}"

  name            = "a-demo-${var.zones[count.index]}-demo"
  datacenter      = "${var.zones[count.index]}"
  type            = "PUBLIC"
  router_hostname = "${lookup(var.zone_router_map_public, "${var.zones[count.index]}")}"
  timeouts {
    create = "25m"
    delete = "30m"
  }
}

// Create Kubernetes cluster in the resource group
resource "ibm_container_cluster" "iks-cluster-demo" {
  name               = "${var.team}-${var.service}-${var.cloud_service}-${lookup(var.region_short, var.region)}"
  org_guid           = "${data.ibm_org.org.id}"
  space_guid         = "${data.ibm_space.space.id}"
  update_all_workers = "${var.update_all_workers}"
  datacenter         = "${var.zones[0]}"
  resource_group_id  = "${data.ibm_resource_group.resource-group.id}"
  region             = "${var.region}"
  hardware           = "${var.hardware}"
  default_pool_size  = "${var.pool_size}"
  machine_type       = "${var.machine_type}"
  public_vlan_id     = "${ibm_network_vlan.public.0.id}"
  private_vlan_id    = "${ibm_network_vlan.private.0.id}"
}

resource "ibm_container_worker_pool" "multizone-demo" {
  worker_pool_name  = "${var.multizone_pool_name}"
  machine_type      = "${var.multizone_machine_type}"
  cluster           = "${ibm_container_cluster.iks-cluster-demo.id}"
  size_per_zone     = "${var.multizone_pool_size_per_zone}"
  hardware          = "${var.multizone_hardware}"
  region            = "${var.region}"
  resource_group_id = "${data.ibm_resource_group.resource-group.id}"

  labels = {
    "mul_az" = "mul_az_pool"
  }
}

resource "ibm_container_worker_pool_zone_attachment" "multizone-demo" {
  count = "${length(var.zones)}"

  cluster           = "${ibm_container_cluster.iks-cluster-demo.id}"
  worker_pool       = "${element(split("/",ibm_container_worker_pool.multizone-demo.id),1)}"
  zone              = "${var.zones[count.index]}"
  private_vlan_id   = "${ibm_network_vlan.private.*.id[count.index]}"
  public_vlan_id    = "${ibm_network_vlan.public.*.id[count.index]}"
  region            = "${var.region}"
  resource_group_id = "${data.ibm_resource_group.resource-group.id}"

  timeouts {
    create = "90m"
    update = "90m"
    delete = "90m"
  }
}

// Datasource returns Kubernetes cluster config (kubeconfig)
// Can be used later with CLI tools by exporting environment variable `KUBECONFIG=<path>`
data "ibm_container_cluster_config" "iks-cluster-demo-config" {
  cluster_name_id   = "${ibm_container_cluster.iks-cluster-demo.name}"
  resource_group_id = "${data.ibm_resource_group.resource-group.id}"

  depends_on = [
    "ibm_container_cluster.iks-cluster-demo",
    "ibm_container_worker_pool.multizone-demo",
    "ibm_network_vlan.private",
    "ibm_network_vlan.public",
  ]
}
