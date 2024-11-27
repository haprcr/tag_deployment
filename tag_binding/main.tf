locals {
  tag_input = {
    for k, v in var.parent_input :
    v.parent_id => v
  }
}

module "tag_binding"{
  source = "./module"
  for_each = local.tag_input
  parent = each.value.parent
  parent_id =each.key
  project_tag_map = var.project_tag_map
}

