# Pre-commit Hooks Documentation

This document provides guidance on installing and using pre-commit hooks for this repository.

## Installation

To set up pre-commit hooks in your local environment, follow these steps:

1. Ensure you have Python installed on your system.
2. Install the `pre-commit` package globally or within a virtual environment:

   ```bash
   pip install pre-commit
   ```

   Alternatively, you can use a package manager like Homebrew on macOS:

   ```bash
   brew install pre-commit
   ```

3. Install the hooks defined in the `.pre-commit-config.yaml` file:

   ```bash
   pre-commit install
   ```

   ```bash
   make install-precommit
   ```

4. Verify the installation by running the hooks against all files:

   ```bash
   pre-commit run --all-files
   ```

## Usage

Pre-commit hooks are automatically triggered before each commit. They ensure code quality and consistency by running various checks and validations. Below is a summary of the hooks configured in this repository:

### General File Hygiene

- **Trailing Whitespace**: Removes trailing whitespace.
- **End-of-File Fixer**: Ensures files end with a newline.
- **YAML and JSON Checks**: Validates syntax for YAML and JSON files.
- **Large File Check**: Warns about files larger than 1MB.
- **Conflict Markers**: Detects unresolved merge conflicts.

### Security Scanning

- **Detect Secrets**: Identifies sensitive data in the codebase.
- **Gitleaks**: Scans for hardcoded secrets like passwords and API keys.

### Linting

- **YAML Lint**: Checks YAML files for syntax and style issues.
- **Markdown Lint**: Ensures consistency in Markdown files.
- **Shellcheck**: Analyzes shell scripts for potential issues.

### Terraform

- **Terraform FMT**: Formats Terraform files.
- **Terraform Docs**: Generates documentation for Terraform modules.
- **TFLint**: Lints Terraform files for best practices.
- **TFSEC**: Scans Terraform code for security vulnerabilities.

### Commit Message Linting

- **Commitlint**: Validates commit messages against conventional commit standards.

### GitHub Actions

- **Workflow Validation**: Ensures GitHub Actions workflows are valid.

## Additional Notes

- If you encounter issues with a specific hook, you can skip it for a particular commit using:

  ```bash
  git commit --no-verify
  ```

- For more information on pre-commit, visit the [official documentation](https://pre-commit.com).
