variable "flavor" {
    type = string
    default = "t3.small"
}

variable "source_image" {
    type = string
}

variable "ssh_secgroup" {
    type = string
}

variable "ssh_username" {
    type = string
}

variable "image_name" {
    type = string
    default = "austraits-api-base-{{timestamp}}"
}

source "openstack" "austraits-api-base" {
    flavor = var.flavor
    source_image = var.source_image
    security_groups = [var.ssh_secgroup]
    ssh_username = var.ssh_username
    image_name = var.image_name
}

build {
    sources = ["source.openstack.austraits-api-base"]

    provisioner "file" {
        source = "packages.txt"
        destination = "/tmp/packages.txt"
    }

    provisioner "shell" {
        scripts = ["userdata.sh"]
    }
}
