terraform {
  backend "s3" {
    bucket                      = "terraform-backend-cos-standard-1ql"
    key                         = "demo/terraform.tfstate"
    key                         = "terraform.tfstate.backup "
    region                      = "us-east"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_get_ec2_platforms      = true
    skip_requesting_account_id  = true
    skip_metadata_api_check     = true
    endpoint                    = "s3.us-east.cloud-object-storage.appdomain.cloud"
    access_key                  = "3af3b51dd9cf4141b63ec53deafc2cde"
    secret_key                  = "5c48a8d0074b7f06d7897397a869f0b58bdd86eed019986d"
  }
}
