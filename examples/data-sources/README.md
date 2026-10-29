# Data Sources Example

This example demonstrates how to use Terraform data sources to query existing AWS infrastructure and resources.

## What This Example Shows

1. **Account Information**: Query current AWS account and region
2. **Availability Zones**: Get available AZs in the current region
3. **VPC Queries**: Find default VPC and subnets
4. **AMI Lookups**: Query latest Amazon Linux and Ubuntu AMIs

## Usage

```bash
# Initialize
terraform init

# Plan to see what data sources will query
terraform plan

# Apply to execute queries and see outputs
terraform apply
```

## Data Sources Used

| Data Source | Purpose |
|-------------|---------|
| `aws_caller_identity` | Get current AWS account ID and ARN |
| `aws_region` | Get current AWS region |
| `aws_availability_zones` | List available AZs |
| `aws_vpc` | Query VPC by filters |
| `aws_subnets` | Query subnets in a VPC |
| `aws_ami` | Find AMIs by filters |

## Best Practices

1. **Filter Specificity**: Use specific filters to get exactly what you need
2. **Most Recent**: Use `most_recent = true` for AMIs to get latest versions
3. **Error Handling**: Be prepared for data sources that might not find resources
4. **Performance**: Data sources are queried every `terraform plan`, keep them efficient

## Example Output

```text
account_id = "123456789012"
region = "ap-southeast-1"
availability_zones = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
default_vpc_id = "vpc-abc123"
amazon_linux_2_ami = "ami-xyz789"
```

## Notes

- This example requires AWS credentials to be configured
- Some data sources (like default VPC) might not exist in all AWS accounts
- AMI IDs change over time as new versions are released

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.21.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_ami.amazon_linux_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnets.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_account_id"></a> [account\_id](#output\_account\_id) | Current AWS account ID |
| <a name="output_amazon_linux_2_ami"></a> [amazon\_linux\_2\_ami](#output\_amazon\_linux\_2\_ami) | Latest Amazon Linux 2 AMI ID |
| <a name="output_amazon_linux_2_ami_name"></a> [amazon\_linux\_2\_ami\_name](#output\_amazon\_linux\_2\_ami\_name) | Latest Amazon Linux 2 AMI name |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | List of available AZs in the region |
| <a name="output_default_subnets"></a> [default\_subnets](#output\_default\_subnets) | Default subnet IDs |
| <a name="output_default_vpc_cidr"></a> [default\_vpc\_cidr](#output\_default\_vpc\_cidr) | Default VPC CIDR block |
| <a name="output_default_vpc_id"></a> [default\_vpc\_id](#output\_default\_vpc\_id) | Default VPC ID |
| <a name="output_region"></a> [region](#output\_region) | Current AWS region |
| <a name="output_ubuntu_ami"></a> [ubuntu\_ami](#output\_ubuntu\_ami) | Latest Ubuntu 22.04 AMI ID |
| <a name="output_ubuntu_ami_name"></a> [ubuntu\_ami\_name](#output\_ubuntu\_ami\_name) | Latest Ubuntu 22.04 AMI name |
<!-- END_TF_DOCS -->
