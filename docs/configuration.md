# Configuration

Reference for all configuration files in this template.

## Terraform Configuration

### `versions.tf`

Defines Terraform and provider version constraints.

```hcl
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

- **Terraform version**: `>= 1.0` allows any 1.x version
- **AWS provider**: `~> 5.0` allows 5.x minor/patch updates
- **Backend**: Defaults to local; S3 backend template available (commented)

### `.terraform-version`

Specifies the exact Terraform version (`1.10.5`) for use with [tfenv](https://github.com/tfutils/tfenv) or [asdf](https://asdf-vm.com/).

### `providers.tf`

AWS provider configuration with default region and auto-tagging.

- **Default region**: `ap-southeast-1` (configurable via `var.region`)
- **Default tags**: `ManagedBy=Terraform` and `Environment` applied to all resources

### `variables.tf`

Root module input variables:

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `env` | `string` | (required) | Environment name |
| `prefix` | `string` | `"dev"` | Resource name prefix |
| `region` | `string` | `"ap-southeast-1"` | AWS region |

### `locals.tf`

Local values for resource naming, environment detection, and common tags.

- `resource_prefix`: `{prefix}-{env}` pattern for consistent naming
- `is_production` / `is_dev`: Boolean flags for conditional logic
- `common_tags`: Merged tags for resources

## Linting and Security

### `.tflint.hcl`

TFLint configuration with the AWS plugin.

**Key settings**:

- `format = "compact"` - Concise output
- `call_module_type = "all"` - Lint all module calls
- AWS plugin `v0.38.0` enabled

**Rule categories**:

| Category | Rules |
|----------|-------|
| Documentation | `terraform_documented_variables`, `terraform_documented_outputs` |
| Typing | `terraform_typed_variables` |
| Naming | `terraform_naming_convention` (snake_case) |
| Version management | `terraform_required_version`, `terraform_required_providers` |
| Code quality | `terraform_deprecated_interpolation`, `terraform_unused_declarations` |
| Module standards | `terraform_module_pinned_source`, `terraform_standard_module_structure` |

### `.checkov.yml`

Checkov security scanner configuration.

- **Frameworks**: `terraform`, `terraform_plan`
- **Quiet mode**: Enabled for clean output
- **Skipped checks**: Documented in [Security](security.md)

## Git and Editor

### `.gitignore`

Ignores Terraform state files, provider plugins, override files, sensitive tfvars, Infracost cache, and MkDocs build output (`site/`).

### `.editorconfig`

Enforces consistent coding styles:

- UTF-8 encoding
- LF line endings
- 2-space indentation
- Trailing whitespace trimming (except markdown and diff files)
- Final newline insertion

### `.pre-commit-config.yaml`

Pre-commit hook configuration. See [Security](security.md) for details on each hook.

**Hook groups**:

1. **File quality**: trailing-whitespace, end-of-file-fixer, check-yaml, check-added-large-files, check-merge-conflict, detect-private-key
2. **Terraform**: terraform_fmt, terraform_validate, terraform_docs, terraform_tflint, terraform_checkov
3. **Security**: gitleaks

## CI/CD

### `.releaserc.json`

Semantic Release configuration.

- **Branches**: `main`, `master`
- **Plugins**: commit-analyzer, release-notes-generator, GitHub releases, changelog, git

Release rules map commit types to version bumps (see [Commit Conventions](commit-conventions.md)).

### `.github/dependabot.yml`

Dependabot configuration for automated dependency updates.

| Ecosystem | Directory | Schedule |
|-----------|-----------|----------|
| `terraform` | `/` | Daily |
| `github-actions` | `/` | Daily |
| `pip` | `/` | Daily |

### `.templatesyncignore`

Files excluded from template repository sync, preventing downstream customizations from being overwritten.

## Documentation

### `mkdocs.yml`

MkDocs site configuration with Material theme.

- **Theme**: Material with dark/light toggle, deep purple primary color
- **Features**: Navigation tabs, search suggestions, code copy
- **Plugins**: Search, minify, git-revision-date-localized

The `site_url`, `repo_url`, and `repo_name` fields use placeholder values (`ops4life/terraform-repo-template`) that are automatically replaced with the actual repository URLs by the `docs-deploy` workflow on first run.
