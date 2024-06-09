# This is a basic workflow to help you get started with Actions

name: terraform_github_action

env:
  ARM_CLIENT_ID: ${{ secrets.ARM_CLIENT_ID }}
  ARM_CLIENT_SECRET: ${{ secrets.ARM_CLIENT_SECRET }}
  ARM_SUBSCRIPTION_ID: ${{ secrets.ARM_SUBSCRIPTION_ID }}
  ARM_TENANT_ID: ${{ secrets.ARM_TENANT_ID }}

# Controls when the workflow will run
on:
  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

  # to trigger workflow on code push
  push:
    branches:
      - main

  # to trigger workflow on PRs
  pull_request:
    branches:
      - main

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: ./azurerm_resource_group
    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - uses: actions/checkout@v4

      - uses: hashicorp/setup-terraform@v3

      - name: Terraform Init
        id: init
        run: |
          terraform init

      - name: Terraform Format
        id: fmt
        run: terraform fmt -check -recursive
        continue-on-error: true

      - name: Terraform Plan
        id: plan
        run: terraform plan -out tfplan
        continue-on-error: false

      # Save plan to artifacts
      - name: Publish Terraform Plan
        uses: actions/upload-artifact@v4
        with:
          name: tfplan
          path: tfplan

      # Create string output of Terraform Plan
      - name: Create String Output
        id: tf-plan-string
        run: |
          TERRAFORM_PLAN=$(terraform show -no-color tfplan)
          delimiter="$(openssl rand -hex 8)"
          echo "summary<<${delimiter}" >> $GITHUB_OUTPUT
          echo "## Terraform Plan Output" >> $GITHUB_OUTPUT
          echo "<details><summary>Click to expand</summary>" >> $GITHUB_OUTPUT
          echo "" >> $GITHUB_OUTPUT
          echo '```terraform' >> $GITHUB_OUTPUT
          echo "$TERRAFORM_PLAN" >> $GITHUB_OUTPUT
          echo '```' >> $GITHUB_OUTPUT
          echo "</details>" >> $GITHUB_OUTPUT
          echo "${delimiter}" >> $GITHUB_OUTPUT

      # Publish Terraform Plan as task summary
      - name: Publish Terraform Plan to Task Summary
        env:
          SUMMARY: ${{ steps.tf-plan-string.outputs.summary }}
        run: |
          echo "$SUMMARY" >> $GITHUB_STEP_SUMMARY

      - name: Terraform Validate
        id: validate
        run: terraform validate -no-color

      # Terraform Apply
      - name: Terraform Apply
        run: terraform apply -auto-approve
