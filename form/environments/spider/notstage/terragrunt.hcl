include {
  path = find_in_parent_folders()
}

terraform {
  source = "../module"
}

inputs = {
  env_type   = "notstage"
  cloud_name = "toast"
  offset     = 128
}
