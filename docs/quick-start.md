# Quick Start

Get up and running with this Terraform template in minutes.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0 (recommended: 1.10.5 via `.terraform-version`)
- [Docker](https://docs.docker.com/get-docker/) (for dev container setup)
- [pre-commit](https://pre-commit.com/#install)
- [TFLint](https://github.com/terraform-linters/tflint)
- [Checkov](https://www.checkov.io/2.Basics/Installing%20Checkov.html)
- AWS credentials configured

## Using the Template

### 1. Create a new repository

Click **Use this template** on GitHub to create a new repository from this template.

### 2. Clone and enter the repository

```bash
git clone https://github.com/<your-org>/<your-repo>.git
cd <your-repo>
```

### 3. Set up pre-commit hooks

```bash
pre-commit install
```

### 4. Initialize TFLint

```bash
tflint --init
```

### 5. Initialize Terraform

```bash
terraform init
```

### 6. Verify the setup

```bash
# Format check
terraform fmt -check -recursive

# Validate configuration
terraform validate

# Run linter
tflint --config=.tflint.hcl

# Run security scan
checkov --config-file .checkov.yml

# Run all pre-commit hooks
pre-commit run --all-files
```

## Dev Container Setup

For a consistent development environment, use the included dev container:

1. Install the [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) VSCode extension
2. Open the repository in VSCode
3. Click **Reopen in Container** when prompted
4. All tools are pre-installed and ready to use

## First Deployment

### 1. Configure AWS credentials

Set up GitHub secrets for CI/CD:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`

### 2. Customize environment variables

Edit the environment-specific tfvars files:

```bash
environments/dev/dev.tfvars    # Development settings
environments/qa/qa.tfvars      # QA/staging settings
environments/prod/prod.tfvars  # Production settings
```

### 3. Plan and apply

```bash
# Plan for dev environment
terraform plan -var-file=environments/dev/dev.tfvars

# Apply when satisfied
terraform apply -var-file=environments/dev/dev.tfvars
```

## Next Steps

- Read the [Usage Guide](usage.md) for the full command reference
- Review the [Repository Structure](repository-structure.md) to understand the layout
- Check [Security](security.md) for scanning configuration
- Set up [CI/CD Workflows](workflows.md) for automated deployments
