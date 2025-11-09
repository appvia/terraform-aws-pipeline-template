# CI/CD Pipeline Documentation

This document provides an overview of the GitHub Actions workflows used in this repository.

## Workflows

### Terraform

**Description**: Automates the process of planning and applying Terraform configurations to manage infrastructure.

**Trigger Events**:

- Push to the `main` branch.
- Pull request targeting the `main` branch.
- Manual dispatch via the GitHub Actions interface.

**Permissions**:

- Contents: Read access to repository contents.
- ID Token: Write access for authentication.
- Pull Requests: Write access to manage pull requests.

**Jobs**:

- **Terraform Plan and Apply**: Uses a reusable workflow to generate and apply Terraform execution plans.

**Secrets**:

- `ORG_ACTIONS_APP_ID`: Application ID for GitHub Actions authentication.
- `ORG_ACTIONS_APP_SECRET`: Secret key for GitHub Actions authentication.
- `ORG_INFRACOST_API_KEY`: API key for Infracost integration.

**Inputs**:

- `aws-account-id`: AWS account ID for deployment.
- `aws-role`: AWS role to assume for deployment.
- `enable-infracost`: Enables cost estimation using Infracost (default: `true`).
- `enable-private-access`: Enables private access for the workflow (default: `true`).
- `additional-dir` (optional): Additional directories to include in the apply stage.
- `additional-dir-optional` (optional): Allows the additional directories to be empty.

### Workflow Validation

**Description**: Validates the syntax and structure of GitHub Actions workflow files.

**Trigger Events**:

- Push to the `main` branch affecting `.github/**` files.
- Pull request targeting the `main` branch affecting `.github/**` files.

**Permissions**:

- Contents: Read access to repository contents.

**Jobs**:

- **Validate GitHub Workflows**:
  - Checks out the repository.
  - Validates YAML syntax for all workflow files.
  - Installs Go and Actionlint for additional validation.
  - Runs Actionlint to ensure workflows adhere to best practices.

### Terraform Destroy

**Description**: Provides a manual workflow to destroy Terraform-managed infrastructure.

**Trigger Events**:

- Manual dispatch via the GitHub Actions interface.

**Inputs**:

- `confirmation`: Name of the repository to confirm the destroy action.
- `aws-account-id`: AWS account ID for the infrastructure to destroy.
- `aws-role`: AWS role to assume for the destroy action.

**Permissions**:

- Contents: Read access to repository contents.
- ID Token: Write access for authentication.
- Pull Requests: Write access to manage pull requests.

**Jobs**:

- **Terraform Destroy**: Uses a reusable workflow to destroy Terraform-managed infrastructure.

## Usage

1. Ensure the required secrets are configured in the repository settings.
2. Trigger the appropriate workflow based on your needs (e.g., push changes, open a pull request, or manually dispatch).
3. Monitor the workflow execution in the GitHub Actions interface.
4. Review the results to ensure the desired actions are completed successfully.

## Additional Notes

- The workflows use reusable components to simplify configuration and ensure consistency.
- For more information on reusable workflows, refer to the [GitHub documentation](https://docs.github.com/en/actions/using-workflows/reusing-workflows).
