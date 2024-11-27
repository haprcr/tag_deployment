variable "tag_creation_input" {
  type = list(object({
    parent    = string,
    parent_id = string,
    tag_key_value_map = list(object({
      tag_key             = string,
      tag_key_description = string,
      tag_value_list      = list(string)
    }))
  }))
}
