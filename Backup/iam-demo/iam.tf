resource "ibm_iam_access_group" "admin" {
  name = "operational-analytics_administrator"
  description = "operational-analytics access group which has 'Administrator' access to resource groups for the team"
}

data "ibm_resource_group" "group" {
  name = "Default"
}

resource "ibm_iam_access_group_policy" "policy" {
  access_group_id = "ibm_iam_access_group.accgrp.id"
  roles           = ["Operator", "Writer"]

  resources {
    resource_group_id = "data.ibm_resource_group.group.id"
  }
}

resource "ibm_iam_access_group" "iks_admin" {
  name = "operational-analytics_iks_adminr"
  description = "operational-analytics access group which has 'Editor', 'Operator', 'Viewer'  and 'Administrator' access to the kubernetes clusters for the team "
}

resource "ibm_iam_access_group_policy" "iks_policy" {
  access_group_id = "ibm_iam_access_group.iks_admin.id"
  roles           = ["Editor", "Operator", "Viewer", "Administrator"]

 
}
