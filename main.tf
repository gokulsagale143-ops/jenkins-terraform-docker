terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Pull the hello-world image
resource "docker_image" "hello" {
  name = "hello-world:latest"
}

# Run the hello-world container
resource "docker_container" "hello" {
  name  = "hello-from-terraform"
  image = docker_image.hello.image_id

  must_run = false # Allow the container to stop/exit after running
  start    = true  # Ensure it starts upon creation
  attach   = true  # Attach to wait for execution to finish
  logs     = true  # Capture output logs
}

output "container_logs" {
  value = docker_container.hello.container_logs
}
