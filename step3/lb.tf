resource "digitalocean_droplet" "lb" {
	image = "ubuntu-16-04-x64"
	name = "${var.team_name}-lb"
	region = "ams3"
	size = "s-1vcpu-1gb"
	private_networking = true
	ssh_keys = [
		"${var.ssh_fingerprint}"
	]

	connection {
		user = "root"
		type = "ssh"
		private_key = "${file(var.private_key)}"
		timeout = "2m"
	}

	provisioner "remote-exec" {
		inline = [
			"export PATH=$PATH:/usr/bin",
			# install haproxy 1.5
			"sudo add-apt-repository -y ppa:vbernat/haproxy-1.5",
			"sudo apt-get update",
			"sudo apt-get -y install haproxy",

			# download haproxy conf
			"sudo wget https://gist.githubusercontent.com/sacheendra/a2bf27a7797d7aa575b5d37c771c61f3/raw/f756b663abc3de168d68158c46e48e5ccd5bde67/cloudworkshop_haproxy_config_1 -O /etc/haproxy/haproxy.cfg",

			# replace ip address variables in haproxy conf to use droplet ip addresses
			"sudo sed -i 's/HAPROXY_PUBLIC_IP/${digitalocean_droplet.lb.ipv4_address}/g' /etc/haproxy/haproxy.cfg",
			"sudo sed -i 's/WWW_1_PRIVATE_IP/${digitalocean_droplet.vm1.ipv4_address_private}/g' /etc/haproxy/haproxy.cfg",
			"sudo sed -i 's/WWW_2_PRIVATE_IP/${digitalocean_droplet.vm2.ipv4_address_private}/g' /etc/haproxy/haproxy.cfg",

			# restart haproxy to load changes
			"sudo service haproxy restart"
		]
	}
}

output "ip of load balancer" {
	value = "${digitalocean_droplet.lb.ipv4_address}"
}