# Deploy Static Website on GCP with Terraform

This example for a static website deployment on GCP using Terraform.

## How do you run this example?

1. Install [Terraform](https://www.terraform.io/).
1. Open up `variables.tf` and set secrets at the top of the file as environment variables and fill in any other variables
   in the file that don't have defaults. E.g.:
    ```bash
    export TF_VAR_REGION=asia-northeast1
    export TF_VAR_ZONE=asia-northeast1-a
    export TF_VAR_PROJECT={{YOUR PROJECT}}
    ```
1. `terraform init`.
1. `terraform plan`.
1. If the plan looks good, run `terraform apply`.
