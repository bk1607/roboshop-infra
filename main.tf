module "ec2" {
  source = "./ec2"
  for_each = var.instances
  component = each.value["name"]
  type = each.value["type"]
  sg_id = module.sg.sg_names

}
module "sg" {
  source = "./sg"
  for_each = var.instances
  component = each.value["name"]
}