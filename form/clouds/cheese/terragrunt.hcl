include {
  path = find_in_parent_folders()
}

terraform {
  source = "../module"
}

inputs = {
  vpc_name = "cheese"
  vpc_cidr = "172.17.0.0/16"
}
