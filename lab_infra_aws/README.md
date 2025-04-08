Infrastrucure 
# Infrastrucure deployment
This is the terraform module needed to deploy the infrstructure. Follow the guide to learn more

## Requirements:
- Create IAM ROLE for ECS
    - Create a task exceution role to be used by ec2 as it follows:
        ```json
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Principal": {
                        "Service": "ecs-tasks.amazonaws.com"
                    },
                    "Action": "sts:AssumeRole"
                }
            ]
        }
        ```
    - Assign the name "ECSTaskExecutionRole"