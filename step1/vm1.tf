variable "do_token" {}
variable "team_name" {}
variable "ssh_fingerprint" {}

provider "digitalocean" {
	token = "${var.do_token}"
}

resource "digitalocean_droplet" "vm1" {
	image = "37049327"
	name = "${var.team_name}-vm1"
	region = "ams3"
	size = "s-1vcpu-1gb"
  # size = "s-2vcpu-2gb"
	ssh_keys = [
	  "${var.ssh_fingerprint}"
	]
}

output "ip" {
  value = "${digitalocean_droplet.vm1.ipv4_address}"
}