variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "name" {
  type = string
}

variable "offset" {
  type = number
}

variable "azs" {
  type = list(string)
}

variable "gateway_id" {
  type    = string
  default = null
}
