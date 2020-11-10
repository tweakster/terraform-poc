include {
  path = find_in_parent_folders()
}

terraform {
  source = "../module"
}

inputs = {
  env_type   = "notlive"
  cloud_name = "cheese"
  offset     = 132
}
