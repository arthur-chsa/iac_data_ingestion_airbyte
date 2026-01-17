# iac_data_ingestion_airbyte

## Snowflake connection

### Generate a pair of keys locally
```openssl genrsa 2048 | openssl pkcs8 -topk8 -inform PEM -out snowflake_rsa_key.p8 -nocrypt```
```openssl rsa -in snowflake_rsa_key.p8 -pubout -out snowflake_rsa_key.pub```

### Set the public key into the user used for the connection
ALTER USER SA_INGESTION_USER SET RSA_PUBLIC_KEY=''

### Add the private key to the Airbyte configuration