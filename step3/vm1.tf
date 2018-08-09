resource "digitalocean_droplet" "vm1" {
	image = "37049327"
	name = "${var.team_name}-vm1"
	region = "ams3"
	size = "s-1vcpu-1gb"
	private_networking = true
	ssh_keys = [
		"${var.ssh_fingerprint}"
	]
}

output "ip of vm1" {
	value = "${digitalocean_droplet.vm1.ipv4_address}"
}