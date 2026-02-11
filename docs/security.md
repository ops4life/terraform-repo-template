# Security

This template implements multi-layer security scanning to catch vulnerabilities, misconfigurations, and secrets before they reach production.

## Security Scanning Layers

### Layer 1: Checkov

[Checkov](https://www.checkov.io/) provides policy-as-code scanning for Terraform configurations.

**Configuration file**: `.checkov.yml`

```yaml
quiet: true
framework:
  - terraform
  - terraform_plan
```

**What it checks**:

- Encryption enabled on storage resources
- Public access restrictions
- Logging and monitoring configuration
- IAM policy best practices
- Network security (security groups, NACLs)
- Backup and recovery settings

**Skipped checks** (configured in `.checkov.yml`):

| Check ID | Reason |
|----------|--------|
| `CKV_AWS_18` | S3 access logging creates circular dependency |
| `CKV2_AWS_62` | S3 event notifications not required for all buckets |
| `CKV_AWS_144` | Cross-region replication is expensive and optional |
| `CKV_AWS_145` | AES256 encryption is sufficient for many use cases |
| `CKV_AWS_300` | Abort incomplete multipart is optional |

**Adding custom skip rules**:

Add entries to the `skip-check` list in `.checkov.yml`:

```yaml
skip-check:
  - CKV_AWS_XXX  # Reason for skipping
```

### Layer 2: TFLint

[TFLint](https://github.com/terraform-linters/tflint) provides linting with the AWS plugin for AWS-specific rules.

**Configuration file**: `.tflint.hcl`

**Enabled rules**:

| Rule | Purpose |
|------|---------|
| `terraform_required_version` | Enforce Terraform version constraint |
| `terraform_required_providers` | Ensure provider version constraints |
| `terraform_typed_variables` | Enforce variable type declarations |
| `terraform_documented_variables` | Require variable descriptions |
| `terraform_documented_outputs` | Require output descriptions |
| `terraform_naming_convention` | Enforce snake_case naming |
| `terraform_deprecated_interpolation` | Catch deprecated syntax |
| `terraform_unused_declarations` | Find unused variables/outputs |
| `terraform_comment_syntax` | Enforce `#` for comments |
| `terraform_module_pinned_source` | Require pinned module sources |
| `terraform_standard_module_structure` | Enforce module file structure |

**AWS plugin**: Version 0.38.0 enables AWS-specific rules that catch resource misconfigurations.

### Layer 3: Gitleaks

[Gitleaks](https://github.com/gitleaks/gitleaks) detects hardcoded secrets in the repository.

**Integration**:

- Pre-commit hook runs on every commit
- Standalone GitHub Actions workflow on pull requests
- Blocks commits containing secrets (API keys, passwords, tokens)

## Secure Defaults

### S3 Bucket Module

The included `modules/s3-bucket` module enforces security best practices:

- **Encryption**: AES256 server-side encryption enabled by default
- **Public access**: All public access blocked by default
- **Versioning**: Configurable, recommended for production
- **Lifecycle rules**: Support for automated object management

### Provider Default Tags

All resources are automatically tagged via provider-level `default_tags`:

```hcl
default_tags {
  tags = {
    ManagedBy   = "Terraform"
    Environment = var.env
  }
}
```

### Naming Conventions

Resource naming follows the pattern `{prefix}-{env}-{resource-type}-{name}`, enforced by TFLint's `terraform_naming_convention` rule with snake_case format.

## Running Security Scans Locally

```bash
# Run Checkov
checkov --config-file .checkov.yml

# Run TFLint (first time: init plugins)
tflint --init
tflint --config=.tflint.hcl

# Run Gitleaks
gitleaks detect --source .

# Run all checks via pre-commit
pre-commit run --all-files
```

## CI/CD Security Integration

Security scanning runs automatically in CI/CD:

- **Pre-commit CI**: Runs Checkov and TFLint on every pull request
- **Checkov workflow**: Standalone security scan on pull requests
- **Gitleaks workflow**: Standalone secret detection on pull requests
- **Pre-deployment**: Terraform validate and format checks before plan/apply

See [CI/CD Workflows](workflows.md) for complete workflow documentation.
