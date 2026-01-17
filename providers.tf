terraform {
  required_providers {
    airbyte = {
      source = "airbytehq/airbyte"
      version = "0.6.5"
    }
  }
}

provider "airbyte" {
  client_id     = var.airbyte_client_id
  client_secret = var.airbyte_client_secret
}
