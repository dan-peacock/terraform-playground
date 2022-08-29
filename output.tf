output "azure_test" {

    value = data.vault_azure_access_credentials.azure_creds.client_id
  
}