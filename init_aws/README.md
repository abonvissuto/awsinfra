# Setup Remote backend

Use this to setup the remote backend on S3.

## Create the remote backend
0. If you haven-t already init the folder 
    ```
    terraform init
    ```
1. Uncomment only the block #LOCAL RUN in main.tf
2. Run the command 
    ```
    terraform apply -auto-approve
    ```
3. Take note of the created bucket
4. Comment the #LOCAL RUN block and uncomment the #REMOTE RUN block
4. Migrate the state to the remote backend using 
    ```
    terraform apply -migrate-state -force-copy
    ```

## Destroy the remote backend
Make sure this is the last operation you do and nothing else depends on this state anymore

1. comment the block #REMOTE RUN and uncomment the #LOCAL RUN block
2. Migrate the state to local backend (so that the bucket can be purged)
    ```
    terraform apply -migrate-state -force-copy
    ```
3. Destroy the resources
    ```
    terraform destroy -auto-approve
    ```
4. Done. Now you can discard all the .tfstate files and .tfstate.backup