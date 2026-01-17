# MySQL Source
resource "airbyte_source_mysql" "sources" {
  for_each     = { for src in var.sources_mysql : src.name => src }
  name         = each.value.name
  workspace_id = var.workspace_id

  configuration = {
    host     = each.value.host
    port     = each.value.port
    database = each.value.database
    username = each.value.username
    password = each.value.password
    ssl_mode = (
      each.value.ssl_mode == "required" ? { required = {} } :
      each.value.ssl_mode == "preferred" ? { preferred = {} } :
      each.value.ssl_mode == "verify_ca" ? { verify_ca = {} } :
      each.value.ssl_mode == "verify_identity" ? { verify_identity = {} } :
      { disabled = {} }
    )
    replication_method = {
      scan_changes_with_user_defined_cursor = {}
    }
  }
}

# Snowflake Destination
resource "airbyte_destination_snowflake" "snowflake_destination" {
  for_each     = { for dest in var.destinations_snowflake : dest.name => dest }
  name         = each.value.name
  workspace_id = var.workspace_id

  configuration = {
    host                = each.value.account
    warehouse           = each.value.warehouse
    database            = each.value.database
    schema              = each.value.schema
    username            = each.value.username
    role                = each.value.role
    private_key_content = each.value.private_key
  }
}

# Airbyte Connections
resource "airbyte_connection" "connections" {
  for_each = {
    for conn in var.connections : conn.name => conn
  }

  name           = each.value.name
  source_id      = airbyte_source_mysql.sources[each.value.source_name].source_id
  destination_id = airbyte_destination_snowflake.snowflake_destination[each.value.destination_name].destination_id

  schedule = each.value.schedule_type == "manual" ? {
    schedule_type = "manual"
  } : {
    schedule_type   = each.value.schedule_type
    cron_expression = each.value.cron_expression
  }
}