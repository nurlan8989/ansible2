data "digitalocean_ssh_key" "example" {
  name = "REBRAIN.SSH.PUB.KEY"
}



resource "digitalocean_ssh_key" "key1" {
  name       = "key1"
  public_key = file(var.public_key1)
}




resource "digitalocean_droplet" "vm" {
  image    = "ubuntu-20-04-x64"
  name = "test"
  region   = "nyc1"
  size     = "s-1vcpu-1gb"
  #ssh_keys = var.ssh_keys
  ssh_keys = [
    digitalocean_ssh_key.key1.id,
    data.digitalocean_ssh_key.example.id
  ]

 
connection {
    type = "ssh"
    user = "root"
    private_key = file(var.private_key_path)
    host = self.ipv4_address
  }
}

resource "local_file" "ansible_inventory" {
     content = <<-EOT
     [vps]
     ${digitalocean_droplet.vm.ipv4_address}
     EOT
     filename = "inventory.yaml"
}
