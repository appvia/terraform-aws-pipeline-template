# Project Documentation

## Introduction

Welcome to the Terraform AWS Pipeline Template repository. This project provides a robust and reusable template for managing CI/CD pipelines and infrastructure as code using Terraform. The repository includes pre-configured workflows, pre-commit hooks, and Makefile targets to streamline development and deployment processes.

## Description

This repository is designed to simplify the management of AWS infrastructure and CI/CD pipelines. It includes:

- **Makefile**: A collection of commands to automate common tasks such as linting, validation, and documentation generation.
- **Pre-commit Hooks**: Tools to enforce code quality and security checks before committing changes [see PRECOMMIT.md](PRECOMMIT.md).
- **GitHub Workflows**: Predefined workflows for Terraform plan, apply, and destroy operations, as well as workflow validation, see [WORKFLOWS.md](WORKFLOWS.md).

## Usage

### Makefile

The Makefile includes the following targets:

- `all`: Runs all tasks including initialization, validation, linting, security checks, formatting, and documentation generation.
- `init`: Initializes Terraform without a backend.
- `validate`: Validates Terraform configurations and runs additional checks like linting and security.
- `lint`: Runs TFLint to check for Terraform best practices.
- `format`: Formats Terraform files using `terraform fmt`.
- `documentation`: Generates documentation using `terraform-docs`.
- `security`: Runs security checks using Trivy.
- `commitlint`: Validates commit messages against conventional commit standards.
- `clean`: Cleans up Terraform state files and lock files.

To use the Makefile, run the following command:

```bash
make <target>
```

For example, to validate your Terraform configurations, run:

```bash
make validate
```

### Additional Documentation

- [Pre-commit Hooks Documentation](PRECOMMIT.md): Learn how to install and use pre-commit hooks to enforce code quality.
- [GitHub Workflows Documentation](WORKFLOWS.md): Understand the CI/CD workflows configured in this repository.

## Additional Notes

This repository is licensed under the GNU General Public License v2. For more details, see the LICENSE file.
