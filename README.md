# Three Tier CI CD

This project will setup AWS CodeBuild to run the project [Three Tier Architecture](https://github.com/hchiao/three-tier-architecture).

## How to deploy

### Setup
* [Install Terraform](https://www.terraform.io/intro/getting-started/install.html)
* Setup your credentials via [AWS Provider](https://www.terraform.io/docs/providers/aws/index.html#access_key)
* Clone this project
* [Before deploying you must manually connect your AWS account to your GitHub account](https://docs.aws.amazon.com/codebuild/latest/APIReference/API_ProjectSource.html)

### Run commands to deploy:
* ```terraform init```
* ```terraform apply```

NOTE:
Error will occur when deploying, however the resources will be provisioned correctly.  For more information on the error please click on the link.
https://github.com/hashicorp/terraform/issues/12285
