terraform {
backend "http" {
    # Serverless backend endpoint
    address = "https://60f0484f.us-south.apigw.appdomain.cloud/terraform/terraform-backend-cos-standard-demo-l28/dev"

    # Optional locking, coment out to disable. Should be set to same value as address
    lock_address   = "https://60f0484f.us-south.apigw.appdomain.cloud/terraform/terraform-backend-cos-standard-demo-l28/dev"
    unlock_address = "https://60f0484f.us-south.apigw.appdomain.cloud/terraform/terraform-backend-cos-standard-demo-l28/dev"

    # API Key for Cloud Object Storage will be passed in as partial backend configuration during Terraform init
     password = "v2mFY3HFCukPFQs-sN0BXMDB7-H7FMI7IGaFMTAt5tsV"

    # Do not change the following
    username               = "cos"
    update_method          = "POST"
    lock_method            = "PUT"
    unlock_method          = "DELETE"
    skip_cert_verification = "false"
 }
}
