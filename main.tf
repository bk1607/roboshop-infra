module "ec2" {

  for_each = var.instances
  source = "./ec2"
  component = each.value["name"]
  type = each.value["type"]
  password = try(each.value["password"],"null")

}
