# 🚧 Terraform Project Template

[![Documentation](https://img.shields.io/badge/docs-mkdocs-blue)](https://username.github.io/github-repo-template/)

This repository provides a structured template for Terraform projects, enabling consistent and scalable infrastructure deployments. The template has best practices, CI/CD integration, and environment-specific configurations to streamline infrastructure management.

## 📁 Repository Structure

```bash
.
├── backend.tf                          # 🔧 Defines the backend configuration for Terraform
├── CHANGELOG.md                        # 📝 Change log of the project
├── .checkov.yml                        # 🔒 Configuration file for Checkov security scanner
├── CODEOWNERS                          # 👥 Defines the code owners for the repository
├── .devcontainer                       # 🐳 Development container configuration
│   ├── devcontainer.json               # 📦 Devcontainer configuration file
│   └── Dockerfile                      # 🐋 Dockerfile for the dev environment
├── .editorconfig                       # 🖊️ Configuration for consistent coding styles
├── environments                        # 🌍 Holds environment-specific variables
│   ├── dev
│   │   └── dev.tfvars                  # 🛠️ Development environment variables
│   ├── prod
│   │   └── prod.tfvars                 # 🚀 Production environment variables
│   └── qa
│       └── qa.tfvars                   # 🔍 QA environment variables
├── .github                             # 🛠️ GitHub-specific configurations
│   ├── dependabot.yml                  # 🤖 Dependabot configuration
│   ├── ISSUE_TEMPLATE                  # 📝 GitHub issue template
│   │   └── issue_template.md           # 📝 Issue template file
│   ├── pull_request_template.md        # 📝 Pull request template
│   └── workflows                       # ⚙️ GitHub Actions workflows
│       ├── lint-pr.yaml                # 🧹 Linting workflow for pull requests
│       ├── pre-commit-auto-update.yaml # 🔄 Pre-commit hook auto-update workflow
│       ├── release.yaml                # 🚀 Release workflow
│       ├── stale.yaml                  # ⏳ Stale issue management workflow
│       ├── template-repo-sync.yaml     # 🔄 Template repository sync workflow
│       └── terraform-aws.yml           # ☁️ Terraform AWS workflow
├── .gitignore                          # 🚫 Files and directories to be ignored by Git
├── LICENSE                             # ⚖️ License for the project
├── locals.tf                           # 🛠️ Local variables for Terraform
├── main.tf                             # 🌐 Main Terraform configuration
├── modules                             # 📦 Custom Terraform modules
│   └── s3-bucket
│       ├── main.tf                     # 🌐 Main configuration for s3-bucket
│       ├── outputs.tf                  # 📤 Output definitions for s3-bucket
│       └── variables.tf                # 📥 Input variables for s3-bucket
├── .pre-commit-config.yaml             # 🛠️ Pre-commit hooks configuration
├── providers.tf                        # ☁️ Provider configurations for Terraform
├── README.md                           # 📖 Project documentation (this file)
├── .releaserc.json                     # 🚀 Semantic release configuration
├── .terraform.lock.hcl                 # 🔒 Terraform lock file
├── .tflint.hcl                         # 🛠️ Terraform linting configuration
├── variables.tf                        # 📥 Input variables for the project
└── .vscode                             # 🖥️ VSCode-specific configurations
    └── extensions.json                 # 🛠️ Recommended extensions for VSCode
```

## 🚀 Getting Started

### 🧰 Prerequisites

- Terraform: Ensure you have Terraform installed.
- Docker: Required for the development container setup.
- VSCode: Recommended for development, with the Dev Containers extension.

### 🖥️ Development Environment

To get started with development, you can use the pre-configured development container:

1. Open in VSCode:

- Install the Dev Containers extension.
- Open the repository in VSCode.
- You should see a prompt to reopen the project in the dev container.

2. Build and Run:

- The dev container is pre-configured with all the necessary tools and extensions.
- You can start writing and testing your Terraform configurations immediately.

### 🛠️ Terraform Configuration

- Backend Configuration: The `backend.tf` file configures the remote state storage for Terraform.
- Environment Variables: The `environments/` directory contains environment-specific variable files (`.tfvars`).
- Modules: Reusable Terraform modules are stored in the `modules/` directory.

### ✅ Pre-Commit Hooks

Pre-commit hooks are set up to ensure code quality and consistency. To install the pre-commit hooks:

```bash
pre-commit install
```

## ⚙️ Semantic Commit Messages
This project uses [Semantic Commit Messages](https://www.conventionalcommits.org/) to ensure meaningful and consistent commit history. The format is as follows:

```php
<type>(<scope>): <subject>
```

### Types

- `feat`: A new feature (e.g., `feat: add login functionality`).
- `fix`: A bug fix (e.g., `fix: resolve login button issue`).
- `docs`: Documentation changes (e.g., `docs: update API documentation`).
- `style`: Code style changes (formatting, missing semi-colons, etc.) without changing logic (e.g., `style: fix indentation`).
- `refactor`: Code changes that neither fix a bug nor add a feature (e.g., `refactor: update user controller structure`).
- `test`: Adding or updating tests (e.g., `test: add unit tests for login service`).
- `chore`: Changes to build process, auxiliary tools, or libraries (e.g., `chore: update dependencies`).

### Scope

Optional: The part of the codebase affected by the change (e.g., `feat(auth): add OAuth support`)

### Subject

A brief description of the change, using the imperative mood (e.g., `fix: resolve issue with user authentication`).

## 🚀 Semantic Release

This project is configured with [Semantic Release](https://semantic-release.gitbook.io/semantic-release) to automate the release process based on your commit messages.

### How It Works

1. Analyze commits: Semantic Release inspects commit messages to determine the type of changes in the codebase.
2. Generate release version: Based on the commit type, it will automatically bump the version following semantic versioning:
- fix → Patch release (e.g., 1.0.1)
- feat → Minor release (e.g., 1.1.0)
- BREAKING CHANGE → Major release (e.g., 2.0.0)
3. Create release notes: It generates a changelog from the commit messages and includes it in the release.
4. Publish: It automatically publishes the new version to the repository (and any other configured registries, e.g., npm).

## 🤝 Contributing

1. Fork the repository.
2. Create a new branch for your feature or bugfix.
3. Submit a pull request with a detailed description of the changes.

## 📜 License

This project is licensed under the [MIT License](LICENSE).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.95.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env"></a> [env](#input\_env) | The environment to deploy the resources | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The prefix for all resource's names | `string` | `"dev"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to deploy the resources | `string` | `"ap-southeast-1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_environment"></a> [environment](#output\_environment) | The environment name |
| <a name="output_region"></a> [region](#output\_region) | The AWS region where resources are deployed |
| <a name="output_resource_prefix"></a> [resource\_prefix](#output\_resource\_prefix) | The prefix used for resource naming |
<!-- END_TF_DOCS -->
