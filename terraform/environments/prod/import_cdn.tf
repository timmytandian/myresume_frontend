# Use the block below to import the resource from AWS
# IMPORTANT: after the import procedure finished, the code below should be commented out.

import {
  to = module.cdn.aws_cloudfront_distribution.s3_distribution
  id = "E3O62X3EJ5ATWI"
}

import {
  to = module.cdn.aws_lambda_function.lambda_edge
  id = "staticweb-origin-response-add-security-header"
}