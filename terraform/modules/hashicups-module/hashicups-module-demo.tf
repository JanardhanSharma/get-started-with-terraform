
variable "coffee-ids" {
  type = list(number)
}

variable "quantity" {
  type = number
}

provider "hashicups" {
  username = "JD"
  password = "demo-password"
}

resource "hashicups_order" "this" {
  dynamic "items" {
    for_each = toset(var.coffee-ids)
    content {
        coffee {
          id = items.key
        }
        quantity = var.quantity
      }
    }
}

output "orders" {
  value = hashicups_order.this.id
}