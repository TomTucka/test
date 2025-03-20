# EC2 Manager Lambda

## Prerequisites
- Terraform
- AWS CLI configured with appropriate credentials

## Deployment

1. Initialize and apply the Terraform configuration:

    ```sh
    cd terraform
    terraform init
    terraform apply
    ```

## Usage

Invoke the Lambda function with an event containing the `instance_name` key to stop EC2 instances with the specified name.

### Management Console

To trigger your Lambda function, you can use the AWS Management Console or AWS CLI. 

### 1. Using AWS Management Console

1. Go to the AWS Management Console.
2. Navigate to the Lambda service.
3. Select your Lambda function.
4. Click on the "Test" button.
5. Configure a test event with the following JSON:

```json
{
  "instance_name": "your-instance-name"
}
```

6. Click "Create" and then "Test" to invoke the Lambda function.

### 2. Using AWS CLI

You can invoke the Lambda function using the AWS CLI with the following command:

```
aws lambda invoke \
  --function-name your-lambda-function-name \
  --payload '{"instance_name": "your-instance-name"}' \
  response.json
```