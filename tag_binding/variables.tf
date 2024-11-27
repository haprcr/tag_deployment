variable "parent_input" {
  type = list(object({
    parent    = string
    parent_id = string
  }))

  default = []
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