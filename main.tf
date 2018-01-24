# ------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ------------------------------------------------------------------------------

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "codebuild_policy" {
  name        = "codebuild-policy"
  path        = "/service-role/"
  description = "Policy used in trust relationship with CodeBuild"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "codebuild_policy_attachment" {
  name       = "codebuild-policy-attachment"
  policy_arn = "${aws_iam_policy.codebuild_policy.arn}"
  roles      = ["${aws_iam_role.codebuild_role.id}"]
}

resource "aws_codebuild_project" "three-tier-architecture" {
  name          = "three-tier-architecture-project"
  description   = "three-tier-architecture-project"
  build_timeout = "5"
  service_role  = "${aws_iam_role.codebuild_role.arn}"

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "hashicorp/terraform"
    type         = "LINUX_CONTAINER"
  }

  source {
    type      = "GITHUB"
    location  = "https://github.com/hchiao/three-tier-architecture"
    buildspec = "buildspec.yml"
    auth {
        type     = "OAUTH"
        resource = "AWS CodeBuild"
    }
  }

  artifacts {
    type = "NO_ARTIFACTS"
  }

}
