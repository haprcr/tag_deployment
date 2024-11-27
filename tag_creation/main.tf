locals {
    tag_key_creation    = flatten([
        for k, v in var.tag_creation_input:[
            for k1, tag_map in v.tag_key_value_map:  {
                parent_id = "${v.parent}/${v.parent_id}"
                tag_key = tag_map.tag_key
                tag_key_description = tag_map.tag_key_description
            }
        ]
    ])

    tag_key_creation_map = tomap({
        for tag_key in local.tag_key_creation : "${tag_key.parent_id}.${tag_key.tag_key}" => tag_key
    })

    tag_key_value_creation   = flatten([
        for k, v in var.tag_creation_input:[
            for k1, tag_map in v.tag_key_value_map:  [
                for k2, tag_value in tag_map.tag_value_list: {
                parent_id = "${v.parent}/${v.parent_id}"
                tag_key = tag_map.tag_key
                # tag_key_id = google_tags_tag_key.key["${v.parent}/${v.parent_id}.${tag_map.tag_key}"].
                tag_key_description = tag_map.tag_key_description
                tag_value = tag_value
            }
        ]
        ]
    ])

    tag_key_value_creation_map = tomap({
        for tag_key_value in local.tag_key_value_creation : "${tag_key_value.parent_id}.${tag_key_value.tag_key}.${tag_key_value.tag_value}" => tag_key_value
    })

    
}


resource "google_tags_tag_key" "key" {
    for_each = local.tag_key_creation_map
    parent = each.value.parent_id
    short_name = each.value.tag_key
    description = each.value.tag_key_description
}


resource "google_tags_tag_value" "value" {
    for_each = local.tag_key_value_creation_map
    parent = "tagKeys/${google_tags_tag_key.key["${each.value.parent_id}.${each.value.tag_key}"].name}"
    short_name = each.value.tag_value
    description = ""
}



