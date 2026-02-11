# Contributing

Guidelines for contributing to this Terraform repository.

## Branching Strategy

All changes must go through feature branches and pull requests.

!!! warning "Critical Rule"
    Never commit directly to the `main` branch. All changes must be made via pull requests.

### Branch Naming

Use descriptive branch names with a type prefix:

| Prefix | Purpose | Example |
|--------|---------|---------|
| `feat/` | New features | `feat/add-rds-module` |
| `fix/` | Bug fixes | `fix/s3-encryption-config` |
| `chore/` | Maintenance tasks | `chore/update-provider-version` |
| `docs/` | Documentation changes | `docs/update-usage-guide` |
| `refactor/` | Code restructuring | `refactor/simplify-locals` |

### Workflow

1. **Create a feature branch** from `main`:

    ```bash
    git checkout main
    git pull origin main
    git checkout -b feat/your-feature-name
    ```

2. **Implement changes** following the [commit conventions](commit-conventions.md)

3. **Run pre-commit hooks** before pushing:

    ```bash
    pre-commit run --all-files
    ```

4. **Push and create a pull request**:

    ```bash
    git push -u origin feat/your-feature-name
    ```

5. **Wait for CI/CD checks** to pass

6. **Merge** after approval

## Pull Request Process

### PR Requirements

- Descriptive title following conventional commit format
- Clear description of changes and motivation
- All CI/CD checks passing
- At least one approval (for team repositories)

### Automated Checks

The following checks run automatically on pull requests:

- Pre-commit CI (formatting, validation, linting, security)
- Terraform documentation generation
- Checkov security scanning
- Gitleaks secret detection
- Infracost cost estimation
- PR title linting

### Review Guidelines

When reviewing Terraform PRs, check for:

- **Security**: No hardcoded secrets, encryption enabled, public access restricted
- **Naming**: Resources follow the `{prefix}-{env}-{type}-{name}` pattern
- **Variables**: All variables are typed and documented
- **Outputs**: All outputs have descriptions
- **Modules**: Reusable modules used where appropriate
- **Cost**: Review Infracost estimates for unexpected costs

## Code Style

### Terraform Conventions

- Use `snake_case` for all resource, variable, output, and local names
- Include descriptions for all variables and outputs
- Use type constraints for all variables
- Prefer `locals` for computed values and repeated expressions
- Keep resources organized: one primary resource type per file for complex modules

### File Organization

Follow the standard Terraform file structure:

```
versions.tf     # Version constraints and backend
providers.tf    # Provider configuration
variables.tf    # Input variables
locals.tf       # Local values
main.tf         # Resource definitions
outputs.tf      # Output values
data.tf         # Data sources (if needed)
```

### Formatting

Terraform formatting is enforced automatically:

- Pre-commit hooks run `terraform fmt`
- CI/CD checks validate formatting
- Use 2-space indentation (enforced by `.editorconfig`)
