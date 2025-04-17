Infrastrucure 
# Infrastrucure deployment
This is the terraform module needed to deploy the infrstructure. Follow the guide to learn more

## Requirements:
- Create IAM ROLE for ECS
    - Create a task execution role to be used by ec2 as it follows:
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
- Create an execution role for the gateway lambda:
    - Create a task exceution role to be used by the gateway lambda:
        Simply create a Role and attach the existing _AmazonBedrockFullAccess_ Policy to it.
        In theory we don't need FullAccess but it gives us flexibility
        Name it "LambdaExecutionRoleBedrockAccess" or change the name accordingly in [main.tf](main.tf)
- Create a file in the _terraform.tfvars_ containing the following variables (values can be changed):
    ```
    gateway_secret                = "<secret>"
    openwebui_admin_user_email    = "<mailbox@email.com>"
    openwebui_admin_user_password = "<password>"
    ```