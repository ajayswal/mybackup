variable "space" {
  default = ""
}

variable "org" {
  default = ""
}

variable "region" {
  default = ""
}

variable "region_short" {
  type = "map"

  default = {
    "au-syd"   = "syd"
    "jp-tok"   = "tok"
    "eu-de"    = "fra"
    "eu-gb"    = "lon"
    "us-south" = "dal"
    "us-east"  = "wdc"
  }
}

variable "zones" {
  type    = "list"
  default = ["dal10", "dal12", "dal13"]
}

variable "zone_router_map_public" {
  type = "map"

  default = {
    "dal10" = "fcr02a.dal10"
    "dal12" = "fcr02a.dal12"
    "dal13" = "fcr02a.dal13"
  }
}

variable "zone_router_map_private" {
  type = "map"

  default = {
    "dal10" = "bcr02a.dal10"
    "dal12" = "bcr02a.dal12"
    "dal13" = "bcr02a.dal13"
  }
}

variable "team" {
  default = "analyticseng1"
}

variable "cloud_service" {
  default = "demo"
}

variable "service" {
  default = "ingestes"
}

variable "work" {
  default = "demo-trial"
}

variable "storage" {
  default = "cos"
}

variable "key_name" {
  default = "key"
}

variable "group" {
  default = "Default"
}

variable "resource_group_id" {
  default = "data.ibm_resource_group.resource-group.id"
}

variable "machine_type" {
  default = "b3c.32x128"
}

variable "hardware" {
  default = "shared"
}

variable "pool_size" {
  default = "1"
}

variable "update_all_workers" {
  default = "false"
}

// *****_Object-Storage_information_*****

variable "objectstorage_plan" {
  default = "standard"
}

variable "objectstorage_location" {
  default = "global"
}

//variable "tags" {
//type = "list"

// default = ["dal01", "dal02", "dal03"]

//}
variable "cloud-platform" {
  default = "ibm"
}

variable "billing" {
  default = "analytics"
}

variable "customer-id" {
  default = "analytics"
}

variable "org-department" {
  default = "analytics"
}

variable "org-environment" {
  default = "trail"
}

variable "Component" {
  default = "ingest-iks-queue-receiver_ingest-iks-etl-encryption_ingest-iks-time-bucket-aggregation_ingest-iks-parquet-writer"
}

variable "es-name" {
  default = "ingest-bar-iks-es"
}

variable "cos-name" {
  default = "ingest-bar-iks-cos"
}

variable "owner" {
  default = "analytics-engineering"
}

variable "alert-severity" {
  default = "low"
}

variable "contact" {
  default = "twcoap@us.ibm.com"
}

// *****_Event_stream_information_*****

variable "role" {
  default = "Writer"
}

variable "paln-type" {
  default = "enterprise"
}

variable "event_stream_plan" {
  default = "standard" 
}

variable "event_stream_location" {
  default = "us-south"
}

// *****_multizone_pool_information_*****

variable "multizone_pool_name" {
  default = "es-iks-multizone_pool"
}

variable "multizone_machine_type" {
  default = "b3c.32x128"
}

variable "multizone_hardware" {
  default = "shared"
}

variable "multizone_pool_size_per_zone" {
  default = 2
}
