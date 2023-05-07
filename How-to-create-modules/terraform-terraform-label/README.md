# terraform-terraform-label

This module generates a label based on namespace, name, environment, id and delimiter.

Pattern is defined as: 

`<NAMESPACE><DELIMITER><NAME><DELIMITER><ENVIRONMENT><DELIMITER><ID>`

`<NAMESPACE>`: project specific identifier (e.g., explore-cloud = ec)

`<NAME>`: resource name (e.g., resource group = rg)

`<ENVIRONMENT>`: environment identifier (dev, stage, prod)

`<ID>`: auto created unique identifier (hexadecimal digits)

`<DELIMITER>`: delimiter (e.g., underscore, dash)

Providers: Terraform

Version: >= 1.4.0