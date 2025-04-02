#LOCAL RUN
terraform {

}

#REMOTE RUN
# terraform {
#     backend "s3" {
#     bucket       = "terraform-storage-config"
#     key          = "global/terraform.tfstate"
#     region       = "eu-west-2"
#     use_lockfile = true
#     encrypt      = true
#   }
# }