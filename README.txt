Assignment: - by Shamik Guha Ray
Successfully deployed the necessary infrastructure setup to execute below assignment:
<img width="667" alt="tasks" src="https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/6cc95d28-d959-4f44-9f15-1f7d585ca039">



Deployment Steps:

Repository Creation:
Created a new repository named "github-nginx-terraform-aws".
GitHub Repo Link is attached [here](https://github.com/ShamikGray/github-nginx-terraform-aws).

Local Setup:
Cloned the repository locally.
Created Terraform configurations.
Pushed the configurations to the master branch of the repository. The GitHub Actions workflows got initiated upon “git push to master”.
 
![gitCommit](https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/d3e0adfa-743e-40c5-be88-ed848bf7c05f)


Terraform Configuration:

Utilised VS Code to craft the Terraform configuration files.
![vscode](https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/37c01b85-c464-48cf-a5b3-51f7ca0df560)



Workflow Utilization:

Implemented two separate workflows: Terraform Plan and Terraform Apply.

By following these steps, the necessary infrastructure for the assignment was successfully deployed. Below is the screenshot of Github Actions Deployment:

Terraform Plan - GitHub Actions Workflow:
![TF_plan](https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/48bdfa06-e398-42a5-9f70-eb1903c9df04)



Terraform Apply - GitHub Action Workflow:
![TF-Apply](https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/ed090482-57f6-4fa3-8319-a40f76f78b39)




Post-Deployment Validation:

Infrastructure Verification:
Ensured the correct provisioning of all infrastructure resources post-deployment.

Accessibility Testing:
Tested accessibility to nginx servers using the load balancer's DNS name.

Multi-AZ Availability Testing:
Validated the load balancer's ability to distribute traffic across instances in multiple availability zones.

Steps Taken:

Accessed the following DNS resolver to perform post-deployment validation:
“http://project-alb-name-2142000161.ap-southeast-1.elb.amazonaws.com/vend_ip”


Screenshot of the Content Served by Our Two Nginx EC2 Servers:
1) 
<img width="790" alt="ec2-response1" src="https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/8a90526d-37ea-4545-8228-4662d35be212">


2)
<img width="790" alt="ec2-response2" src="https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/be8d480c-ef1f-404e-9443-de13c6219f00">




Attached the README containing the steps to setup the s3 bucket before triggering the terraform init/plan/apply.
![Refer-README-s3](https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/127103de-ce72-4a37-92e5-9f8b9e51e5a5)

# Steps to Create an S3 Bucket and Add README File

## Step 1: Sign in to AWS Console
- Log in to your AWS Management Console.

## Step 2: Navigate to S3
- Go to the S3 service from the AWS services dashboard.

## Step 3: Create Bucket
- Click on the "Create bucket" button.
- Enter the bucket name as "project-terraform-state-backup".
- Choose the region where you want to create the bucket.
- Click "Next".

## Step 4: Configure Options
- Optionally, configure additional settings like versioning, logging, tags, etc. as per your requirements.
- Click "Next".

## Step 5: Set Permissions
- Leave the default settings or configure bucket permissions as needed.
- Click "Next".

## Step 6: Review
- Review the bucket configuration.
- Click "Create bucket".
 
