output "lambda_arn" {
  value = aws_serverlessapplicationrepository_cloudformation_stack.rotate_stack.outputs.RotationLambdaARN
}
