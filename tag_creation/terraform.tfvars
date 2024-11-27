tag_creation_input = [
  {
    parent    = "projects"
    parent_id = "winter-arena-435115-h3"
    tag_key_value_map = [
      {
        tag_key             = "Application ID",
        tag_key_description = "Linked to the application catalogue",
        tag_value_list      = ["xyappcode11", "xyappcode12", "xyappcode13"]
      },
      {
        tag_key             = "Environment ID",
        tag_key_description = "Environment",
        tag_value_list      = ["prod", "dev", "staging", "test"]
      }
    ]
  },
  {
    parent    = "organizations"
    parent_id = "6827187836"
    tag_key_value_map = [
      {
        tag_key             = "Application ID",
        tag_key_description = "Linked to the application catalogue",
        tag_value_list      = ["xyappcode11", "xyappcode12"]
      },
      {
        tag_key             = "Environment ID",
        tag_key_description = "Environment",
        tag_value_list      = ["prod", "dev", "staging", "test"]
      }
    ]
  }
]
