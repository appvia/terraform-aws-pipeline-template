![Github Actions](../../actions/workflows/terraform.yml/badge.svg)

# NAME

## Description

Add a description of the terraform pipeline here

## Usage

Add example usage here

```hcl
module "example" {
  source  = "appvia/<NAME>/aws"
  version = "0.0.1"

  # insert variables here
}
```

## Update Documentation

The `terraform-docs` utility is used to generate this README. Follow the below steps to update:

1. Make changes to the `.terraform-docs.yml` file
2. Fetch the `terraform-docs` binary (https://terraform-docs.io/user-guide/installation/)
3. Run `make documentation`

<!-- BEGIN_TF_DOCS -->

## Providers

No providers.

## Inputs

| Name                                          | Description                    | Type          | Default | Required |
| --------------------------------------------- | ------------------------------ | ------------- | ------- | :------: |
| <a name="input_tags"></a> [tags](#input_tags) | Tags to apply to all resources | `map(string)` | n/a     |   yes    |

## Outputs

No outputs.

<!-- END_TF_DOCS -->
