variable "parent" {
  type        = string
  description = "Retrieve the projects from either folder or organization. If the value is folder, the tag bindings are performed for all the projects"
}

variable "parent_id" {
  type        = string
  description = "ID of the parent"
}

variable "project_tag_map" {
  type = list(
    object({
    project_id     = string
    tag_value_name = string
    tag_key_id     = string
  }))

  default = []

}