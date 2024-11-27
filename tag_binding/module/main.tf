
# Define local values
locals {
  projects_list = try(
    [for project in data.google_projects.list_projects.projects : project.project_id],
    []
  )

  tag_value_map_v1 = {
    for k, v in var.project_tag_map :
    "${v.project_id}.${v.tag_value_name}.${v.tag_key_id}" => {
      project_number   = data.google_project.project[v.project_id].number
      tag_value_name   = v.tag_value_name
      tag_key_id       = v.tag_key_id
    }
    if contains(local.projects_list, v.project_id)
  }

  tag_value_map_v2 = {
    for k, v in local.tag_value_map_v1 :
    k => {
      project_number   = v.project_number
      tag_value_id   = data.google_tags_tag_value.tag_value_id[k].id
    }
  }

}


data "google_projects" "list_projects" {
  filter = var.parent == "folder" ? "parent.id:${var.parent_id} parent.type:folder" : "parent.id:${var.parent_id} parent.type:organization"
}


data "google_project" "project" {
  for_each   = toset(local.projects_list)
  project_id = each.key
}

data "google_tags_tag_value" "tag_value_id"{
  for_each = local.tag_value_map_v1
  parent = "tagKeys/${each.value.tag_key_id}"
  short_name = each.value.tag_value_name
}


resource "google_tags_tag_binding" "binding" {
  for_each = local.tag_value_map_v2
    parent = "//cloudresourcemanager.googleapis.com/projects/${each.value.project_number}"
    tag_value = "${each.value.tag_value_id}"
}
