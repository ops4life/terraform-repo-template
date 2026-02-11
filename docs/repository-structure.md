# Repository Structure

Annotated directory tree with descriptions of every file and directory.

## Directory Tree

```
.
├── .checkov.yml                        # Checkov security scanner configuration
├── .devcontainer/                      # Development container configuration
│   ├── devcontainer.json               # Devcontainer settings and extensions
│   └── Dockerfile                      # Docker image for dev environment
├── .editorconfig                       # Consistent coding styles across editors
├── .github/                            # GitHub-specific configurations
│   ├── dependabot.yml                  # Automated dependency updates
│   ├── ISSUE_TEMPLATE/
│   │   └── issue_template.md           # Issue template for bug reports/features
│   ├── pull_request_template.md        # PR template with checklist
│   └── workflows/                      # GitHub Actions workflows
│       ├── automerge.yaml              # Auto-merge bot PRs
│       ├── checkov.yaml                # Standalone Checkov security scan
│       ├── docs.yaml                   # Documentation build and deploy
│       ├── gitleaks.yaml               # Secret detection scan
│       ├── infracost.yaml              # Cost estimation for PRs
│       ├── lint-pr.yaml                # PR title linting
│       ├── pre-commit-auto-update.yaml # Auto-update pre-commit hooks
│       ├── pre-commit-ci.yaml          # Pre-commit checks on PRs
│       ├── release.yaml                # Semantic release automation
│       ├── stale.yaml                  # Stale issue/PR management
│       ├── template-repo-sync.yaml     # Template repository sync
│       ├── terraform-aws.yml           # Terraform plan/apply/destroy
│       ├── tf-docs.yaml                # Auto-generate Terraform docs
│       └── update-license.yml          # Auto-update license year
├── .gitignore                          # Git ignore rules
├── .pre-commit-config.yaml             # Pre-commit hooks configuration
├── .releaserc.json                     # Semantic release configuration
├── .templatesyncignore                 # Files excluded from template sync
├── .terraform-version                  # Terraform version for tfenv/asdf
├── .terraform.lock.hcl                 # Terraform dependency lock file
├── .tflint.hcl                         # TFLint linting configuration
├── .vscode/
│   └── extensions.json                 # Recommended VSCode extensions
├── BEST-PRACTICES.md                   # Best practices implementation summary
├── CHANGELOG.md                        # Auto-generated changelog
├── CLAUDE.md                           # AI assistant guidance
├── CODEOWNERS                          # Code ownership definitions
├── LICENSE                             # MIT license
├── README.md                           # Project documentation
├── TF-DOCS.md                          # Auto-generated Terraform documentation
├── docs/                               # MkDocs documentation source
│   ├── changelog.md                    # Changelog process documentation
│   ├── commit-conventions.md           # Conventional commits guide
│   ├── configuration.md                # Configuration file reference
│   ├── contributing.md                 # Contributing guidelines
│   ├── index.md                        # Documentation home page
│   ├── quick-start.md                  # Getting started guide
│   ├── repository-structure.md         # This file
│   ├── security.md                     # Security scanning documentation
│   ├── stylesheets/
│   │   └── extra.css                   # Custom MkDocs styles
│   ├── usage.md                        # Usage guide and commands
│   └── workflows.md                    # CI/CD workflow documentation
├── environments/                       # Environment-specific variables
│   ├── dev/
│   │   └── dev.tfvars                  # Development settings
│   ├── prod/
│   │   └── prod.tfvars                 # Production settings
│   └── qa/
│       └── qa.tfvars                   # QA/staging settings
├── examples/                           # Example configurations
│   ├── complete-infrastructure/        # Full stack example
│   ├── data-sources/                   # AWS data source patterns
│   └── module-composition/             # Module reuse patterns
├── locals.tf                           # Local values and naming logic
├── main.tf                             # Main resource definitions
├── mkdocs.yml                          # MkDocs site configuration
├── modules/                            # Reusable Terraform modules
│   └── s3-bucket/
│       ├── main.tf                     # S3 bucket resources
│       ├── outputs.tf                  # Module outputs
│       ├── README.md                   # Module documentation
│       └── variables.tf                # Module input variables
├── outputs.tf                          # Root module outputs
├── providers.tf                        # AWS provider configuration
├── requirements.txt                    # Python dependencies for MkDocs
├── variables.tf                        # Root module input variables
└── versions.tf                         # Terraform and provider versions
```

## Key Directories

### `environments/`

Contains environment-specific variable files. Each environment has its own directory with a `.tfvars` file defining configuration values appropriate for that environment (instance sizes, feature flags, retention periods, etc.).

### `modules/`

Reusable Terraform modules following the standard structure (`main.tf`, `variables.tf`, `outputs.tf`, `README.md`). Each module includes validation, documentation, and secure defaults.

### `examples/`

Production-ready example configurations demonstrating common patterns. Each example is self-contained with its own README.

### `.github/workflows/`

GitHub Actions workflow files for CI/CD automation. See [CI/CD Workflows](workflows.md) for documentation of each workflow.

### `docs/`

MkDocs documentation source files. Built and deployed to GitHub Pages automatically.
