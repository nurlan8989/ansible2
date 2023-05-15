output "droplet_ip_address" {
  value = ["${digitalocean_droplet.vm[*].ipv4_address}"]
}




output "droplet_vm_name" {
  value = digitalocean_droplet.vm[*].name
}

