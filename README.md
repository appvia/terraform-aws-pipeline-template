![Github Actions](../../actions/workflows/terraform.yml/badge.svg)

# Terraform AWS Pipeline Template

## Introduction

This repository is a **GitHub template** for new [Terraform](https://www.terraform.io/) projects that deploy infrastructure to **AWS**. It ships with opinionated defaults for local development, quality gates, and a GitHub Actions pipeline that plans and applies changes using reusable workflows from [appvia-cicd-workflows](https://github.com/appvia/appvia-cicd-workflows).

Use it when you want a new infrastructure repository to start with:

- Terraform 1.11+ with an S3 remote backend (configured in CI, not locally)
- AWS provider 6.x
- Pre-commit hooks (formatting, linting, security scanning, conventional commits)
- A `Makefile` for validate, lint, format, security, and documentation generation
- GitHub Actions for **plan/apply** on `main` and pull requests, **workflow validation**, **manual destroy**, and **Dependabot** automation
- [Renovate](https://docs.renovatebot.com/) and [Infracost](https://www.infracost.io/) integration in CI

The root module is intentionally minimal (provider constraints, tagging variable, and backend block). After creating a repository from this template, add your own `.tf` resources and environment-specific values under `values/`.

## Getting started

### Create a repository from this template

1. On GitHub, choose **Use this template** → **Create a new repository** (or fork/clone this repo and rename it).
2. Clone your new repository locally.
3. Install the tools used by the Makefile and pre-commit hooks (at minimum: [Terraform](https://developer.hashicorp.com/terraform/install), [tflint](https://github.com/terraform-linters/tflint), [trivy](https://aquasecurity.github.io/trivy/), [pre-commit](https://pre-commit.com/), and optionally [terraform-docs](https://terraform-docs.io/), [actionlint](https://github.com/rhysd/actionlint), and [commitlint](https://commitlint.js.org/)).

```bash
git clone git@github.com:appvia/my-new-terraform-repo.git
cd my-new-terraform-repo
pip install pre-commit
pre-commit install
```

### Configure AWS and GitHub Actions

Replace the placeholders in the workflow files with your environment details.

**`.github/workflows/terraform.yml`** — plan and apply on push/PR to `main`:

```yaml
with:
  aws-account-id: "123456789012"
  aws-role: "MyTerraformDeployRole"
  enable-infracost: true
  enable-private-access: true
  # additional-dir: builds          # optional: copy extra dirs into apply stage
  # additional-dir-optional: true
```

**`.github/workflows/destroy.yml`** — manual destroy (requires typing the repository name as confirmation):

```yaml
with:
  aws-account-id: "123456789012"
  aws-role: "MyTerraformDeployRole"
  enable-private-access: true
```

Configure these **organization or repository secrets** (names are fixed by the reusable workflows):

| Secret | Purpose |
| --- | --- |
| `ORG_ACTIONS_APP_ID` | GitHub App ID for OIDC/authentication in CI |
| `ORG_ACTIONS_APP_SECRET` | GitHub App private key or secret |
| `ORG_INFRACOST_API_KEY` | Infracost API key for cost estimates on PRs |

The S3 backend in `terraform.tf` is populated by the pipeline; local runs use `terraform init -backend=false` via the Makefile.

### Define tags and environment values

Edit `values/production.tfvars` (or add further `values/*.tfvars` files) and reference them from your pipeline as needed:

```hcl
tags = {
  Environment = "Production"
  GitRepo     = "https://github.com/appvia/my-new-terraform-repo"
  Owner       = "Engineering"
  Product     = "LandingZone"
  Provisioner = "Terraform"
}
```

Pass tags into resources from your Terraform code:

```hcl
resource "aws_s3_bucket" "example" {
  bucket = "my-org-example-bucket"

  tags = var.tags
}
```

### Add infrastructure

Create new `.tf` files alongside `terraform.tf` and `variables.tf`. For example, a minimal starting layout:

```
.
├── terraform.tf      # versions, backend, provider
├── variables.tf      # shared inputs (e.g. tags)
├── main.tf           # your resources (add this)
├── values/
│   └── production.tfvars
└── .github/workflows/
    ├── terraform.yml
    ├── destroy.yml
    └── workflows.yml
```

## Usage examples

### Local validation

Run the same checks CI expects before opening a pull request:

```bash
make validate    # init, validate, lint, format, security, commitlint, examples
make lint        # tflint + actionlint on workflows
make format      # terraform fmt -recursive
make security    # trivy config (CRITICAL/HIGH)
make clean       # remove .terraform dirs and lock files
```

Run everything (init through documentation generation):

```bash
make all
```

### Pre-commit

Hooks run automatically on `git commit`. To run them manually across the repo:

```bash
pre-commit run --all-files
```

See [docs/PRECOMMIT.md](docs/PRECOMMIT.md) for the full hook list.

### CI/CD behaviour

| Workflow | Trigger | What it does |
| --- | --- | --- |
| [Terraform](.github/workflows/terraform.yml) | Push/PR to `main` (ignores docs/Makefile/README-only changes), `workflow_dispatch` | Plan on PRs; apply on `main` |
| [Workflow Validation](.github/workflows/workflows.yml) | Changes under `.github/**` | YAML and actionlint checks |
| [Terraform Destroy](.github/workflows/destroy.yml) | Manual only | Destroys managed infrastructure after confirmation |

Changes under `.github/`, `docs/`, `Makefile`, `README.md`, or `scripts/` do not trigger the Terraform plan/apply workflow, so you can adjust pipeline metadata without a full infra run.

Detailed workflow documentation: [docs/WORKFLOWS.md](docs/WORKFLOWS.md).

### Manually destroy infrastructure

In GitHub Actions, run **Terraform Destroy**, enter the repository name as `confirmation`, and supply the AWS account ID and role. This calls the shared destroy workflow in `appvia-cicd-workflows`.

### Generate README tables

Provider, input, and output tables below are maintained by [terraform-docs](https://terraform-docs.io/). After changing variables or outputs:

1. Adjust `.terraform-docs.yml` if needed.
2. Install `terraform-docs`.
3. Run `make documentation`.

## Further documentation

- [docs/README.md](docs/README.md) — overview of Makefile targets and repo layout
- [docs/PRECOMMIT.md](docs/PRECOMMIT.md) — pre-commit installation and hooks
- [docs/WORKFLOWS.md](docs/WORKFLOWS.md) — GitHub Actions reference

## License

This project is licensed under the GNU General Public License v2.0. See [LICENSE](LICENSE).

<!-- BEGIN_TF_DOCS -->
## Providers

No providers.

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
