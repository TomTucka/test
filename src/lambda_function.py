import boto3


def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    instance_name = event['instance_name']

    # Describe instances to find the one with the matching name
    response = ec2.describe_instances(
        Filters=[
            {
                'Name': 'tag:Name',
                'Values': [instance_name]
            }
        ]
    )

    # Extract instance IDs
    instance_ids = []
    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instance_ids.append(instance['InstanceId'])

    # Stop instances
    if instance_ids:
        ec2.stop_instances(InstanceIds=instance_ids)
        return {
            'statusCode': 200,
            'body': f'Successfully stopped instances: {instance_ids}'
        }
    else:
        return {
            'statusCode': 404,
            'body': 'No instances found with the given name'
        }
