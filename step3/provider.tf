variable "do_token" {}
variable "team_name" {}
variable "private_key" {}
variable "ssh_fingerprint" {}

provider "digitalocean" {
  token = "${var.do_token}"
}