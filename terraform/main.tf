module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "=> 4.0"

  function_name = "ec2-manager-lambda"
  description   = "Lambda function to manage EC2 instances"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.11"
  
  source_path = "../src"
  
  timeout     = 30
  memory_size = 128

  attach_policy_statements = true
  policy_statements = {
    cloudwatch_logs = {
      effect    = "Allow",
      actions   = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      resources = ["arn:aws:logs:*:*:*"]
    },
    ec2_describe = {
      effect    = "Allow",
      actions   = [
        "ec2:DescribeInstances",
        "ec2:DescribeInstanceStatus"
      ],
      resources = ["*"]
    },
    ec2_stop = {
      effect    = "Allow",
      actions   = [
        "ec2:StopInstances"
      ],
      resources = ["*"]
    }
  }

  environment_variables = {
  }

  tags = {
    Name               = "ec2-manager-lambda"
    ManagedByTerraform = true   
  }
}

# Output the Lambda function ARN
output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = module.lambda_function.lambda_function_arn
}

# Output the IAM Role ARN used by the Lambda
output "lambda_role_arn" {
  description = "The ARN of the IAM role created for the Lambda Function"
  value       = module.lambda_function.lambda_role_arn
}