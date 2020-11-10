include {
  path = find_in_parent_folders()
}

terraform {
  source = "../module"
}

inputs = {
  vpc_name = "toast"
  vpc_cidr = "172.16.0.0/16"
}
