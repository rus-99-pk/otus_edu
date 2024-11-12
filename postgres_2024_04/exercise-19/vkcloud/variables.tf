variable "image_name" {
  type = string
  default = "Ubuntu-20.04-Mlflow"
}

variable "compute_flavor" {
  type = string
  default = "Standard-2-4-50"
}

variable "key_pair_name" {
  type = string
  default = "admuser_probook-430-g8"
}

variable "availability_zone_name" {
  type = string
  default = "MS1"
}
