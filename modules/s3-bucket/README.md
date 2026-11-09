# S3 Bucket Module

This module creates an S3 bucket with security best practices enabled by default.

## Features

- Server-side encryption (AES256)
- Versioning support
- Public access blocking
- Lifecycle rules configuration
- Comprehensive tagging

## Usage

```hcl
module "s3_bucket" {
  source = "./modules/s3-bucket"

  bucket_name        = "my-unique-bucket-name"
  environment        = "dev"
  enable_versioning  = true
  enable_encryption  = true

  lifecycle_rules = [
    {
      id                       = "archive-old-files"
      enabled                  = true
      transition_days          = 90
      transition_storage_class = "GLACIER"
    }
  ]

  tags = {
    Project = "MyProject"
    Owner   = "TeamName"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | ~> 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_name | Name of the S3 bucket (must be globally unique) | `string` | n/a | yes |
| environment | Environment name (dev, qa, prod) | `string` | n/a | yes |
| enable_versioning | Enable versioning for the S3 bucket | `bool` | `true` | no |
| enable_encryption | Enable server-side encryption | `bool` | `true` | no |
| tags | Additional tags to apply | `map(string)` | `{}` | no |
| lifecycle_rules | List of lifecycle rules | `list(object)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The name of the bucket |
| bucket_arn | The ARN of the bucket |
| bucket_domain_name | The bucket domain name |
| bucket_regional_domain_name | The bucket region-specific domain name |
| bucket_region | The AWS region this bucket resides in |
| versioning_enabled | Whether versioning is enabled |
| encryption_enabled | Whether encryption is enabled |

## Security

This module implements security best practices:

- **Encryption at rest**: AES256 server-side encryption enabled by default
- **Public access**: All public access blocked by default
- **Versioning**: Enabled by default for data protection
- **Bucket key**: Enabled to reduce encryption costs

## Examples

### Production Bucket with Lifecycle

```hcl
module "prod_bucket" {
  source = "./modules/s3-bucket"

  bucket_name       = "myapp-prod-data"
  environment       = "prod"
  enable_versioning = true
  enable_encryption = true

  lifecycle_rules = [
    {
      id                       = "archive-logs"
      enabled                  = true
      transition_days          = 30
      transition_storage_class = "STANDARD_IA"
    },
    {
      id              = "delete-old-versions"
      enabled         = true
      expiration_days = 90
    }
  ]
}
```

### Development Bucket

```hcl
module "dev_bucket" {
  source = "./modules/s3-bucket"

  bucket_name       = "myapp-dev-testing"
  environment       = "dev"
  enable_versioning = false
  enable_encryption = true
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.100.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Name of the S3 bucket (must be globally unique) | `string` | n/a | yes |
| <a name="input_enable_encryption"></a> [enable\_encryption](#input\_enable\_encryption) | Enable server-side encryption for the S3 bucket | `bool` | `true` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Enable versioning for the S3 bucket | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, qa, prod) | `string` | n/a | yes |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | List of lifecycle rules for the bucket | <pre>list(object({<br/>    id                       = string<br/>    enabled                  = bool<br/>    expiration_days          = optional(number)<br/>    transition_days          = optional(number)<br/>    transition_storage_class = optional(string)<br/>    abort_incomplete_days    = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to the S3 bucket | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the bucket |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The bucket domain name |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | The name of the bucket |
| <a name="output_bucket_region"></a> [bucket\_region](#output\_bucket\_region) | The AWS region this bucket resides in |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | The bucket region-specific domain name |
| <a name="output_encryption_enabled"></a> [encryption\_enabled](#output\_encryption\_enabled) | Whether encryption is enabled |
| <a name="output_versioning_enabled"></a> [versioning\_enabled](#output\_versioning\_enabled) | Whether versioning is enabled |
<!-- END_TF_DOCS -->
