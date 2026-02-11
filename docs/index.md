# Terraform Repo Template

A structured template for Terraform projects, enabling consistent and scalable infrastructure deployments with best practices, CI/CD integration, and environment-specific configurations.

## Features

- **Multi-environment support** - Pre-configured dev, qa, and prod environments with environment-specific tfvars
- **Security scanning** - Multi-layer scanning with Checkov, TFLint, and Gitleaks
- **CI/CD pipelines** - GitHub Actions workflows for validation, deployment, cost estimation, and release management
- **Pre-commit hooks** - Automated code quality checks including formatting, validation, and secret detection
- **Module system** - Production-ready reusable Terraform modules with documentation
- **Auto-tagging** - All resources automatically tagged with `ManagedBy` and `Environment`
- **Semantic releases** - Automated versioning and changelog generation from conventional commits
- **Dev container** - Pre-configured development environment with all required tools

## Quick Navigation

| Section | Description |
|---------|-------------|
| [Quick Start](quick-start.md) | Get up and running in minutes |
| [Usage Guide](usage.md) | Full command reference and working with environments |
| [Repository Structure](repository-structure.md) | Annotated directory tree and file descriptions |
| [Contributing](contributing.md) | Branching strategy, PR process, and code review |
| [Commit Conventions](commit-conventions.md) | Conventional commits format and version impact |
| [Configuration](configuration.md) | Reference for all configuration files |
| [Security](security.md) | Security scanning layers and secure defaults |
| [CI/CD Workflows](workflows.md) | All GitHub Actions workflows documented |
| [Changelog](changelog.md) | Release history and changelog process |

## Tech Stack

| Tool | Purpose |
|------|---------|
| Terraform >= 1.0 | Infrastructure as Code |
| AWS Provider ~> 5.0 | Cloud provider |
| TFLint | Linting with AWS plugin |
| Checkov | Policy-as-code security scanning |
| Gitleaks | Secret detection |
| Semantic Release | Automated versioning |
| Infracost | Cost estimation |
| terraform-docs | Auto-generated documentation |
| Pre-commit | Git hook management |
