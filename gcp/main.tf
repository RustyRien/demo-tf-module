terraform {

  required_version = ">= 1.0.0"

  required_providers {

    google = {

      source = "hashicorp/google"

      version = "~> 5.0"

    }

  }

}

provider "google" {

  project = var.project_id

  region = var.region

  zone = var.zone

}

resource "google_compute_instance" "default" {

  name = var.instance_name

  machine_type = var.machine_type

  zone = var.zone

  tags = var.tags

  labels = var.labels

  boot_disk {

    initialize_params {

      image = var.image

      # Optional: Add size or type here if you want to expose them as variables

      # size = var.disk_size

      # type = var.disk_type

    }

  }

  network_interface {

    network = var.network

    subnetwork = var.subnetwork != "" ? var.subnetwork : null

    # Including an empty access_config block assigns an ephemeral public IP.

    # Remove this block if you want an internal-only instance.

    access_config {

      // Ephemeral public IP

    }

  }

  # Ensure the VM terminates cleanly (good for templates)

  scheduling {

    automatic_restart = true

    on_host_maintenance = "MIGRATE"

  }

  # Optional: Define a startup script inline or via another variable

  # metadata_startup_script = "echo 'Hello from InfraKitchen' > /test.txt"

  # Ignore changes to ssh-keys if they are managed outside of Terraform (e.g., OS Login)

  lifecycle {

    ignore_changes = [

      metadata["ssh-keys"]

    ]

  }

}

variable "project_id" {

  description = "The ID of the GCP project where resources will be created."

  type = string

}

variable "region" {

  description = "The region to deploy the instance in."

  type = string

  default = "us-central1"

}

variable "zone" {

  description = "The zone to deploy the instance in."

  type = string

  default = "us-central1-a"

}

variable "instance_name" {

  description = "The name of the compute instance."

  type = string

  default = "ik-template-instance"

}

variable "machine_type" {

  description = "The machine type to use for the instance."

  type = string

  default = "e2-medium"

}

variable "image" {

  description = "The image from which to initialize the boot disk."

  type = string

  default = "debian-cloud/debian-11"

}

variable "network" {

  description = "The VPC network to attach the instance to."

  type = string

  default = "default"

}

variable "subnetwork" {

  description = "The subnetwork to attach the instance to (optional, uses auto-mode network if empty)."

  type = string

  default = ""

}

variable "tags" {

  description = "A list of network tags to attach to the instance."

  type = list(string)

  default = ["http-server", "https-server"]

}

variable "labels" {

  description = "A map of key/value label pairs to assign to the instance."

  type = map(string)

  default = {

    environment = "dev"

    managed-by = "infrakitchen"

  }

}

