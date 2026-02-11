# Changelog

## Process

This project uses [Semantic Release](https://semantic-release.gitbook.io/) to automate versioning and changelog generation.

### How It Works

1. **Commit analysis**: Semantic Release inspects commit messages on the `main` branch
2. **Version determination**: The commit type determines the version bump:
    - `fix` / `perf` / `refactor` → Patch release (e.g., 1.0.**1**)
    - `feat` → Minor release (e.g., 1.**1**.0)
    - `BREAKING CHANGE` → Major release (e.g., **2**.0.0)
3. **Changelog update**: `CHANGELOG.md` is updated with release notes generated from commit messages
4. **GitHub release**: A new release is created with generated release notes

### Configuration

The release process is configured in `.releaserc.json`:

- **Branches**: Releases are triggered from `main` and `master`
- **Changelog**: Written to `CHANGELOG.md` in the repository root
- **Commit message**: `chore(release): version X.Y.Z [skip ci]`

## Release History

The full changelog is maintained in the repository's [CHANGELOG.md](https://github.com) file. It is automatically updated with each release.

See the [GitHub Releases](https://github.com) page for downloadable release artifacts and notes.

!!! note
    The links above will point to your repository once the documentation site URL is configured by the docs workflow.
