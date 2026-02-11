# Usage Guide

Complete command reference and guide for working with this Terraform template.

## Command Reference

### Formatting

```bash
# Auto-format all Terraform files
terraform fmt -recursive

# Check formatting without modifying files
terraform fmt -check -recursive
```

### Validation

```bash
# Validate configuration syntax
terraform validate

# Run TFLint (first time: downloads plugins)
tflint --init
tflint --config=.tflint.hcl

# Run Checkov security scan
checkov --config-file .checkov.yml
```

### Planning and Applying

```bash
# Plan for a specific environment
terraform plan -var-file=environments/dev/dev.tfvars
terraform plan -var-file=environments/qa/qa.tfvars
terraform plan -var-file=environments/prod/prod.tfvars

# Apply for a specific environment
terraform apply -var-file=environments/dev/dev.tfvars

# View current outputs
terraform output
```

### Pre-commit Hooks

```bash
# Install hooks (required before first commit)
pre-commit install

# Run all hooks on all files
pre-commit run --all-files

# Run a specific hook
pre-commit run terraform_fmt --all-files

# Update hooks to latest versions
pre-commit autoupdate
```

### Documentation

```bash
# Generate Terraform documentation
terraform-docs markdown table --output-file README.md .
```

## Working with Environments

This template supports three environments with different configurations:

### Development (`dev`)

- Cost-optimized settings (e.g., `t3.micro`, single instance)
- Minimal backup and monitoring
- Simplified networking

### QA (`qa`)

- Production-like architecture at reduced capacity
- Full testing capabilities enabled
- All features active for validation

### Production (`prod`)

- High availability with multi-AZ deployment
- Enhanced monitoring and alerting
- Long retention periods
- Deletion protection enabled

### Switching Environments

Always specify the environment tfvars file when running Terraform commands:

```bash
terraform plan -var-file=environments/<env>/<env>.tfvars
terraform apply -var-file=environments/<env>/<env>.tfvars
```

## Working with Modules

### Using Existing Modules

The `modules/` directory contains reusable Terraform modules. Use them in `main.tf`:

```hcl
module "my_bucket" {
  source = "./modules/s3-bucket"

  bucket_name = "${local.resource_prefix}-my-bucket"
  environment = var.env

  versioning_enabled = true

  tags = local.common_tags
}
```

### Creating New Modules

Follow the standard module structure:

```
modules/my-module/
  ├── main.tf        # Resources
  ├── variables.tf   # Inputs with validation
  ├── outputs.tf     # Outputs with descriptions
  └── README.md      # Documentation
```

Ensure your module:

- Uses typed variables with descriptions
- Includes validation blocks where appropriate
- Follows snake_case naming conventions
- Has comprehensive outputs with descriptions

### Naming Conventions

Resources follow the pattern: `{prefix}-{env}-{resource-type}-{name}`

This is defined in `locals.tf` using `local.resource_prefix` and enforced by TFLint's snake_case rules.

## Working with Examples

The `examples/` directory contains production-ready patterns:

| Example | Description |
|---------|-------------|
| `data-sources/` | AWS data source usage (VPC, AMI, account info) |
| `module-composition/` | Module reuse and composition patterns |
| `complete-infrastructure/` | Full stack integration template |

Each example includes a README with usage instructions.

## Backend Configuration

### Local Backend (Default)

The template defaults to a local backend for development. State is stored in `terraform.tfstate`.

### S3 Backend (Production)

For team collaboration, configure the S3 backend in `versions.tf`:

```hcl
backend "s3" {
  bucket         = "your-terraform-state-bucket"
  key            = "your-project/terraform.tfstate"
  region         = "ap-southeast-1"
  dynamodb_table = "terraform-state-lock"
  encrypt        = true
}
```

!!! warning
    After changing the backend configuration, run `terraform init -migrate-state` to migrate existing state.
