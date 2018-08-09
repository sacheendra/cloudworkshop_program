resource "digitalocean_droplet" "vm2" {
	image = "37048288"
	name = "${var.team_name}-vm2"
	region = "ams3"
	size = "s-1vcpu-1gb"
	private_networking = true
	ssh_keys = [
		"${var.ssh_fingerprint}"
	]
}

output "ip of vm2" {
	value = "${digitalocean_droplet.vm2.ipv4_address}"
}