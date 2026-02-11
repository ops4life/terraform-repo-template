# CI/CD Workflows

This repository includes 14 GitHub Actions workflows for quality assurance, security scanning, deployment, and maintenance.

## Overview

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| [Pre-commit CI](#pre-commit-ci) | Pull requests | Comprehensive code quality checks |
| [Checkov](#checkov) | PRs, push to main | Security and compliance scanning |
| [Gitleaks](#gitleaks) | PRs, push, manual | Secret detection |
| [Lint PR](#lint-pr) | Pull requests | PR title validation |
| [Terraform Docs](#terraform-docs) | Pull requests | Auto-generate TF documentation |
| [Infracost](#infracost) | Pull requests | Cost estimation |
| [Terraform CI/CD](#terraform-cicd) | Manual dispatch | Plan, apply, and destroy |
| [Release](#release) | Push to main, manual | Semantic versioning and releases |
| [Documentation](#documentation) | Push to main, PRs | Build and deploy docs site |
| [Pre-commit Auto-update](#pre-commit-auto-update) | Weekly, push/PR to main | Update pre-commit hooks |
| [Automerge](#automerge) | Pull requests | Auto-merge bot PRs |
| [Stale](#stale) | Daily schedule | Close stale issues/PRs |
| [Template Repo Sync](#template-repo-sync) | Weekly, manual | Sync with upstream template |
| [Update License](#update-license) | Push to main | Update license year |

## Pull Request Workflows

### Pre-commit CI

**File**: `.github/workflows/pre-commit-ci.yaml`
**Trigger**: `pull_request_target`

Runs the full suite of pre-commit hooks on pull requests:

- Terraform formatting (`terraform fmt`)
- Terraform validation (`terraform validate`)
- TFLint linting
- Checkov security scanning
- terraform-docs documentation generation
- Gitleaks secret detection
- File quality checks (trailing whitespace, YAML syntax, etc.)

Auto-commits any formatting fixes back to the PR branch.

### Checkov

**File**: `.github/workflows/checkov.yaml`
**Trigger**: Pull requests (open/sync/reopen/edit), push to main/master

Standalone security and compliance scanning with Checkov. Uploads SARIF results to the GitHub Security tab for centralized findings.

### Gitleaks

**File**: `.github/workflows/gitleaks.yaml`
**Trigger**: Pull requests, push events, manual dispatch

Scans the repository for hardcoded secrets, API keys, and sensitive data using Gitleaks. Prevents credential leaks from reaching the codebase.

### Lint PR

**File**: `.github/workflows/lint-pr.yaml`
**Trigger**: `pull_request_target` (open/sync/reopen/edit)

Validates pull request titles follow the [Conventional Commits](commit-conventions.md) format. Posts a comment explaining the error if validation fails and removes it when fixed.

Accepted types: `fix`, `feat`, `docs`, `ci`, `chore`, `style`, `refactor`, `test`, `revert`

### Terraform Docs

**File**: `.github/workflows/tf-docs.yaml`
**Trigger**: Pull requests

Auto-generates Terraform documentation using [terraform-docs](https://terraform-docs.io/). Renders documentation into `TF-DOCS.md` and commits changes back to the PR branch.

### Infracost

**File**: `.github/workflows/infracost.yaml`
**Trigger**: `pull_request_target`

Generates infrastructure cost estimates using [Infracost](https://www.infracost.io/). Compares baseline costs (main branch) against the PR changes and posts a detailed cost analysis as a PR comment.

!!! note
    Requires the `INFRACOST_API_KEY` secret to be configured.

## Deployment Workflow

### Terraform CI/CD

**File**: `.github/workflows/terraform-aws.yml`
**Trigger**: Manual dispatch (`workflow_dispatch`)

The main deployment pipeline for Terraform infrastructure.

**Inputs**:

| Input | Options | Description |
|-------|---------|-------------|
| `environment` | dev, qa, prod | Target environment |
| `action` | plan, apply, destroy | Action to perform |

**Steps**:

1. Checkout code
2. Setup Terraform (version from `TF_VERSION` env var)
3. Configure AWS credentials
4. `terraform init`
5. Format check and validation
6. `terraform plan` with environment-specific tfvars
7. Upload plan artifact (5-day retention)
8. Apply or destroy (if selected)
9. Capture and upload outputs (30-day retention)

**Security features**:

- GitHub Environment protection rules support
- OIDC-ready permissions for AWS authentication
- Plan artifact upload for review before apply
- Environment-specific variable files

!!! tip
    Configure approval requirements for the `prod` environment in **Settings > Environments** to require manual approval before production deployments.

## Release and Maintenance

### Release

**File**: `.github/workflows/release.yaml`
**Trigger**: Push to main, manual dispatch

Runs [Semantic Release](https://semantic-release.gitbook.io/) to automatically:

- Analyze commit messages
- Determine version bump (major/minor/patch)
- Update `CHANGELOG.md`
- Create GitHub release with notes
- Tag the release commit

### Documentation

**File**: `.github/workflows/docs.yaml`
**Trigger**: Push to main (docs changes), pull requests (docs changes)

Builds and deploys the MkDocs documentation site to GitHub Pages.

**Jobs**:

- **configure**: Detects repository URL and updates `mkdocs.yml` placeholders on first run
- **validate**: Runs `mkdocs build --strict` on PRs to catch errors
- **deploy**: Deploys to GitHub Pages via `mkdocs gh-deploy --force`

Only triggers on changes to `docs/**`, `mkdocs.yml`, or `requirements.txt`.

### Pre-commit Auto-update

**File**: `.github/workflows/pre-commit-auto-update.yaml`
**Trigger**: Weekly (Monday midnight), push to main, PR to main

Automatically updates pre-commit hooks to their latest versions and creates a PR with the changes if updates are found.

### Automerge

**File**: `.github/workflows/automerge.yaml`
**Trigger**: `pull_request_target`

Automatically enables squash merge for specific bot PRs:

- Dependabot dependency updates
- License updates
- Pre-commit hook updates

### Stale

**File**: `.github/workflows/stale.yaml`
**Trigger**: Daily schedule (midnight UTC)

Manages stale issues and pull requests:

- Marks as stale after **7 days** of inactivity
- Closes after **3 more days** without activity
- Exempt labels: `bug`, `wip`, `on-hold`, `auto-update`

### Template Repo Sync

**File**: `.github/workflows/template-repo-sync.yaml`
**Trigger**: Weekly (Monday midnight), manual dispatch

Syncs the repository with the upstream template repository. Creates a PR with template updates if changes exist. Uses `.templatesyncignore` to exclude customized files.

!!! note
    Requires the `WORKFLOW_TOKEN` secret with `contents: write` and `pull-requests: write` permissions.

### Update License

**File**: `.github/workflows/update-license.yml`
**Trigger**: Push to main

Automatically updates the LICENSE file with the current year and organization name. Creates a PR if changes are detected.

## Required Secrets

| Secret | Used By | Description |
|--------|---------|-------------|
| `AWS_ACCESS_KEY_ID` | Terraform CI/CD | AWS access key |
| `AWS_SECRET_ACCESS_KEY` | Terraform CI/CD | AWS secret key |
| `AWS_REGION` | Terraform CI/CD | AWS region |
| `INFRACOST_API_KEY` | Infracost | Infracost API key |
| `WORKFLOW_TOKEN` | Template Repo Sync | GitHub token with write permissions |
