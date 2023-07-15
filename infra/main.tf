terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}

module "iam_lambda" {
  source = "./modules/iam/lambda"
}

module "lambda_stop" {
  source             = "./modules/lambda"
  name               = "slackbot-stop"
  execution_role_arn = module.iam_lambda.execution_role_arn
}

module "bucket" {
  source = "./modules/s3"
}

module "apigw" {
  source = "./modules/apigw"
}

module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  subnet = module.vpc.subnet
  az     = module.vpc.az
}
