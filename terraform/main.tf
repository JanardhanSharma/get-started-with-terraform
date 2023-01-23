terraform {
  required_providers {
    hashicups = {
      version = "~> 0.3.1"
      source  = "hashicorp.com/edu/hashicups"
    }
  }
}





variable "quantity" {
  type    = number
  default = 1
}


#Local variable
locals {
  ids = [
    for coffee in data.hashicups_coffees.all.coffees :
    coffee.id
  ]
}

#Data source
data "hashicups_coffees" "all" {}

output "ids" {
  value = local.ids
}

module "hashicups-module" {
  source     = "./modules/hashicups-module"
  quantity   = 1
  coffee-ids = local.ids
}

output "created-order" {
  value = module.hashicups-module.orders
}

