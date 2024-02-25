#data "aws_s3_bucket" "existing_bucket" {
 # bucket = "project-terraform-state-backup"
#}
#
#resource "aws_s3_bucket" "terraform_state_backup" {
#  count = var.create_bucket && length(data.aws_s3_bucket.existing_bucket) == 0 ? 1 : 0
#  bucket = "project-terraform-state-backup"
#}
# 

# It's recommended to create the S3 bucket manually before running Terraform commands like init, plan, or apply.
# This allows Terraform to directly use the pre-existing bucket for storing its state files,
# preventing any issues related to bucket creation during Terraform execution.
# By managing the bucket creation separately, you ensure that the bucket is set up correctly
# and is available when needed by Terraform.


#Refer ./github-nginx-terraform-aws/README.txt file to know how to create a s3 bucket.