#data "aws_s3_bucket" "existing_bucket" {
 # bucket = "project-terraform-state-backup"
#}
#
#resource "aws_s3_bucket" "terraform_state_backup" {
#  count = var.create_bucket && length(data.aws_s3_bucket.existing_bucket) == 0 ? 1 : 0
#  bucket = "project-terraform-state-backup"
#}
#

#No need to  s3 bucket,


# create pipeline stage and run via aws cli before running the terraform plan.