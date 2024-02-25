Assignment: - by Shamik Guha Ray
Successfully deployed the necessary infrastructure setup to execute below assignment:
<img width="667" alt="tasks" src="https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/26ce8db0-9898-421a-9187-bf80fdfab4a8">

Final Terraform-Apply for you to review which was used to deploy the overall infra:
https://github.com/ShamikGray/github-nginx-terraform-aws/actions/runs/8039482447/job/21956548174

Final Terraform-Plan for you to review which was used to deploy the overall infra:
https://github.com/ShamikGray/github-nginx-terraform-aws/actions/runs/8039482448/job/21956548173

Deployment Steps:

Repository Creation:
Created a new repository named "github-nginx-terraform-aws".
GitHub Repo Link is attached [here](https://github.com/ShamikGray/github-nginx-terraform-aws).

Local Setup:
Cloned the repository locally.
Created Terraform configurations.
Pushed the configurations to the master branch of the repository. The GitHub Actions workflows got initiated upon “git push to master”.
 
![gitCommit](https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/f124a45c-8a0f-4984-8987-270e753f890b)


Terraform Configuration:

Utilised VS Code to craft the Terraform configuration files.
![vscode](https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/8044ae7f-04d2-4ef5-aea1-d75b4853a581)


Workflow Utilization:

Implemented two separate workflows: Terraform Plan and Terraform Apply.

By following these steps, the necessary infrastructure for the assignment was successfully deployed. Below is the screenshot of Github Actions Deployment:

Terraform Plan - GitHub Actions Workflow:
![TF_plan](https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/057cbe94-bce9-471e-bc68-09df2d5f0d2a)

Link - https://github.com/ShamikGray/github-nginx-terraform-aws/actions/runs/8039482448/job/21956548173

Terraform Apply - GitHub Action Workflow:
![TF-Apply](https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/20edf3ed-9aa9-4091-8d73-27b3850d8f7f)

Link - https://github.com/ShamikGray/github-nginx-terraform-aws/actions/runs/8039482447/job/21956548174

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
<img width="790" alt="ec2-response1" src="https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/588d5b57-fc65-4520-a5b7-927c8fe67f44">


2)
<img width="790" alt="ec2-response2" src="https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/e222155b-49dd-408d-9498-f367ffa803c4">




Attached the README containing the steps to setup the s3 bucket before triggering the terraform init/plan/apply.
![Refer-README-s3](https://github.com/ShamikGray/github-nginx-terraform-aws/assets/158448051/7ed29795-72c5-494f-8e3b-3cba367ad7d1)
