# Terraform Workspaces with GitHub Branches

## Overview

This project demonstrates managing multiple AWS environments using Terraform Workspaces and GitHub branch-based workflow.

GitHub branches are used to manage Terraform code changes, while Terraform Workspaces are used to maintain separate infrastructure states for different environments.

---

## GitHub Branch Strategy

This project uses two GitHub branches:

### dev branch

Used for:
- Developing new Terraform changes
- Testing infrastructure updates
- Making changes before production deployment


### master branch

Used for:
- Stable Terraform code
- Production-ready changes


---

## Terraform Workspace Strategy

Terraform Workspaces are used to separate environment states.

Workspaces:default, dev


Each workspace maintains its own Terraform state.


---

## Development Workflow

### 1. Switch to dev branch

```bash
git checkout dev


---

## Development Workflow

### 1. Switch to dev branch

```bash
git checkout dev

# Make infrastructure changes:
terraform plan
terraform apply

Production Workflow

After testing changes in development:

1. Merge changes into master
git checkout master
git merge dev

2. Select production workspace
terraform workspace select prod

3. terraform workspace select prod
terraform plan
terraform apply

Terraform Workspace Commands

Initialize Terraform:
terraform init

List workspaces:
terraform workspace list

Create workspace:
terraform workspace new dev
terraform workspace new prod

Check current workspace:
terraform workspace show

Project Structure
terraform-workspace/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
└── README.md

Benefits
Separate development and production environments
Same Terraform code for multiple environments
Independent Terraform state files
Safer infrastructure changes
Git-based version control workflow

Tools Used
Terraform
AWS
GitHub
Infrastructure as Code (IaC)

