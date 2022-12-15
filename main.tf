data "aws_region" "current" {}

data "aws_serverlessapplicationrepository_application" "single_user_rotator" {
  application_id = "arn:aws:serverlessrepo:us-east-1:297356227824:applications/SecretsManagerRDSMySQLRotationSingleUser"
}

resource "aws_serverlessapplicationrepository_cloudformation_stack" "rotate_stack" {
  name             = var.name
  application_id   = data.aws_serverlessapplicationrepository_application.single_user_rotator.application_id
  semantic_version = data.aws_serverlessapplicationrepository_application.single_user_rotator.semantic_version
  capabilities     = data.aws_serverlessapplicationrepository_application.single_user_rotator.required_capabilities

  parameters = {
    endpoint            = "https://secretsmanager.${data.aws_region.current.name}.amazonaws.com"
    functionName        = var.name
    kmsKeyArn           = var.kms_key_arn
    vpcSubnetIds        = join(",", var.lambda_subnet_ids)
    vpcSecurityGroupIds = var.lambda_security_group_id
  }
}
