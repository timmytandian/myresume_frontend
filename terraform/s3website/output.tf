output "upload_directory" {
    value       = "${local.upload_directory}"
    description = "The directory where its content will be uploaded to S3 bucket"
}

output "aws_s3_bucket" {
    value       = aws_s3_bucket.tf_resume_timmytandian.bucket
    description = "The s3 bucket name that stores the static website resource."
}