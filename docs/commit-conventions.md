# Commit Conventions

This project uses [Conventional Commits](https://www.conventionalcommits.org/) to ensure a meaningful, consistent commit history and enable automated releases.

## Format

```
<type>(<scope>): <subject>

<body>
```

### Type (Required)

The type determines the version bump triggered by [Semantic Release](https://semantic-release.gitbook.io/):

| Type | Description | Version Bump |
|------|-------------|-------------|
| `feat` | A new feature | Minor (1.**1**.0) |
| `fix` | A bug fix | Patch (1.0.**1**) |
| `perf` | Performance improvement | Patch (1.0.**1**) |
| `refactor` | Code restructuring | Patch (1.0.**1**) |
| `docs` | Documentation changes | None |
| `chore` | Maintenance tasks | None |
| `test` | Test additions/updates | None |
| `style` | Formatting changes | None |

### Scope (Optional)

The part of the codebase affected by the change. Common scopes:

- `s3` - S3 bucket module
- `vpc` - VPC configuration
- `ci` - CI/CD workflows
- `deps` - Dependencies
- `devcontainer` - Dev container setup

### Subject (Required)

A brief description in imperative mood (e.g., "add", not "added" or "adds").

## Examples

### Feature

```
feat(s3): add encryption configuration for buckets

Configure AES256 encryption for all S3 buckets to meet
security compliance requirements.
```

### Bug Fix

```
fix(provider): correct default region configuration
```

### Breaking Change

```
feat(backend): migrate to S3 backend

BREAKING CHANGE: Local backend is no longer the default.
Existing state must be migrated with terraform init -migrate-state.
```

!!! note
    A `BREAKING CHANGE:` note in the commit body triggers a **major** version bump (e.g., 1.0.0 → **2**.0.0).

## Release Process

Releases are fully automated via Semantic Release:

1. Commits are analyzed on the `main` branch
2. Version is bumped based on commit types
3. `CHANGELOG.md` is updated automatically
4. A GitHub release is created with release notes

The release workflow is configured in `.releaserc.json`. See [CI/CD Workflows](workflows.md) for details.

## PR Title Linting

Pull request titles are validated against the conventional commit format by the `lint-pr` workflow. Ensure your PR title follows the same `<type>(<scope>): <subject>` format.
