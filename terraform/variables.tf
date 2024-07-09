variable "digitalocean_token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/ms.pub"
}

variable "ssh_private_key_path" {
  description = "Path to the SSH private key"
  type        = string
  default     = "~/.ssh/ms"
}
