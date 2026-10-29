# Module Composition Example

This example demonstrates how to compose multiple modules together to build more complex infrastructure.

## What This Example Shows

1. **Module Reuse**: Using the same module multiple times with different configurations
2. **Environment-Specific Logic**: Applying different settings based on environment
3. **Module Dependencies**: Passing outputs from one module to another
4. **Conditional Resources**: Creating resources based on conditions

## Architecture

```
module-composition/
├── Application Bucket (S3)
│   ├── Versioning (prod only)
│   ├── Encryption (always)
│   └── Lifecycle rules (prod only)
└── Logs Bucket (S3)
    ├── No versioning
    ├── Encryption (always)
    └── 30-day expiration
```

## Usage

```bash
# Initialize
terraform init

# Plan for dev environment
terraform plan

# Plan for prod environment
terraform plan -var="environment=prod"

# Apply
terraform apply -var="environment=prod"
```

## Best Practices Demonstrated

1. **DRY Principle**: Reuse the same module for different purposes
2. **Environment Awareness**: Different configurations per environment
3. **Module Outputs**: Collect and expose module outputs
4. **Locals for Organization**: Use locals to organize complex values
5. **Conditional Logic**: Apply different settings based on variables

## Module Dependencies

```
application_bucket (s3-bucket)
    ↓
logs_bucket (s3-bucket)
    ↓
local.bucket_info
    ↓
outputs
```

## Notes

- Bucket names must be globally unique in S3
- Production environment enables versioning and lifecycle rules
- Logs bucket automatically deletes objects after 30 days

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_application_bucket"></a> [application\_bucket](#module\_application\_bucket) | ../../modules/s3-bucket | n/a |
| <a name="module_logs_bucket"></a> [logs\_bucket](#module\_logs\_bucket) | ../../modules/s3-bucket | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | `"dev"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Resource name prefix | `string` | `"example"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"ap-southeast-1"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_all_buckets"></a> [all\_buckets](#output\_all\_buckets) | Map of all bucket IDs |
| <a name="output_application_bucket"></a> [application\_bucket](#output\_application\_bucket) | Application bucket details |
| <a name="output_logs_bucket"></a> [logs\_bucket](#output\_logs\_bucket) | Logs bucket details |
<!-- END_TF_DOCS -->
