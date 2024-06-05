terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_ssh_key" "default" {
  name       = "default-key"
  public_key = file(var.ssh_public_key_path)
}

resource "digitalocean_vpc" "ms-dev-vpc" {
    name = "ms-dev-vpc"
    region = "fra1"
}

resource "digitalocean_droplet" "keycloak" {
  name               = "keycloak-droplet"
  region             = "fra1"
  size               = "s-1vcpu-1gb"
  image              = "debian-12-x64"
  ssh_keys           = [digitalocean_ssh_key.default.id]
  backups            = false
  ipv6               = false
  vpc_uuid = digitalocean_vpc.ms-dev-vpc.id

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.ssh_private_key_path)
    host        = self.ipv4_address
  }
}

output "keycloak-server-ip" {
    value = digitalocean_droplet.keycloak.ipv4_address
}

resource "digitalocean_droplet" "dev-server" {
  name               = "dev-server"
  region             = "fra1"
  size               = "s-1vcpu-1gb"
  image              = "debian-12-x64"
  ssh_keys           = [digitalocean_ssh_key.default.id]
  backups            = false
  ipv6               = false
  vpc_uuid = digitalocean_vpc.ms-dev-vpc.id

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.ssh_private_key_path)
    host        = self.ipv4_address
  }
}

output "dev-server-ip" {
    value = digitalocean_droplet.dev-server.ipv4_address
}

resource "digitalocean_droplet" "sonarqube-server" {
    name = "sonarqube-server"
    region = "fra1"
    size = "s-2vcpu-4gb"
    image = "debian-12-x64"
    ssh_keys    = [digitalocean_ssh_key.default.id]
    backups = false
    ipv6 = false
    vpc_uuid = digitalocean_vpc.ms-dev-vpc.id

    connection {
        type        = "ssh"
        user        = "root"
        private_key = file(var.ssh_private_key_path)
        host        = self.ipv4_address
    }

}

output "sonarqube-server-ip" {
    value = digitalocean_droplet.sonarqube-server.ipv4_address
}

// TODO: Setup "digitalocean_firewall"
