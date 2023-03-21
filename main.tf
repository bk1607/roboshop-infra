module "ec2" {

  for_each = var.instances
  source = "./ec2"
  component = each.value["name"]
  type = each.value["type"]
  sg_component = each.key

}
