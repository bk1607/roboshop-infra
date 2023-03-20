module "ec2" {
  source = "./ec2"
  for_each = var.instances
  component = each.value["name"]
  type = each.value["type"]

}