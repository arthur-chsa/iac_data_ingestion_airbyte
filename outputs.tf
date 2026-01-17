output "source_ids" {
  description = "IDs of the created Airbyte sources."
  value       = { for name, src in airbyte_source_mysql.sources : name => src.source_id }
}

output "snowflake_destination_ids" {
  description = "IDs of the created Airbyte Snowflake destinations."
  value       = { for name, dest in airbyte_destination_snowflake.snowflake_destination : name => dest.destination_id }
}

output "connection_ids" {
  description = "A map of connection names to their IDs."
  value       = { for name, conn in airbyte_connection.connections : name => conn.connection_id }
}