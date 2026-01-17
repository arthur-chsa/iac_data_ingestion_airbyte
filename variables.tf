# Airbyte Provider variables
variable "airbyte_client_id" {
  type        = string
  description = "Airbyte client ID"
  sensitive   = true
}

variable "airbyte_client_secret" {
  type        = string
  description = "Airbyte client secret"
  sensitive   = true
}

# Common variables
variable "workspace_id" {
  type        = string
  description = "The Airbyte workspace ID."
}

# Sources configuration
variable "sources_mysql" {
  type = list(object({
    name              = string
    host              = string
    database          = string
    username          = string
    password          = string
    port              = optional(number, 3306)
    ssl_mode          = optional(string, "required")
  }))
  description = "List of MySQL sources to create."
  sensitive   = false
}

# Snowflake Destinations configuration
variable "destinations_snowflake" {
  type = list(object({
    name        = string
    account     = string
    warehouse   = string
    database    = string
    schema      = string
    username    = string
    private_key = string
    role        = optional(string, "PUBLIC")
  }))
  description = "List of Snowflake destinations to create."
  sensitive   = false
}

# Connection variables
variable "connections" {
  type = list(object({
    name             = string
    source_name      = string
    destination_name = string
    schedule_type    = string
    cron_expression  = optional(string)
  }))
  description = "A list of connections to create."
  default = [
    {
      name             = "MySQL to Snowflake - Manual Sync"
      source_name      = "CloudSQL_MySQL"
      destination_name = "Production_Snowflake"
      schedule_type    = "manual"
    }
  ]
}