
data "archive_file" "lambda_edge" {
  type        = "zip"
  output_path = "/tmp/myresume_frontend/lambda_edge.zip"
  source_file = var.lambda_edge_input_file
}

resource "aws_lambda_function" "lambda_edge" {
  function_name = "${var.env}-myresume-frontend-add-security-header"
  description = "Lambda to modify CloudFront response header (${var.env} environment)."
  filename         = "${data.archive_file.lambda_edge.output_path}"
  source_code_hash = "${data.archive_file.lambda_edge.output_base64sha256}"

  handler = "index.handler"
  runtime = "nodejs20.x"
  role    = "${data.aws_iam_role.lambda_edge.arn}"

  publish  = true
}

data "aws_iam_role" "lambda_edge" {
  name = var.lambda_edge_iam_role
}
# If we want to create a new IAM role for the Lambda Edge, 
# uncomment the 3 resources below:
# 1. aws_iam_role
# 2. aws_iam_role_policy_document
# 3. aws_iam_role_policy 

/*
resource "aws_iam_role" "lambda_edge" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "lambda_edge" {
  statement {
    sid = "1"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

resource "aws_iam_role_policy" "lambda_edge" {
  role   = "${aws_iam_role.lambda_edge.id}"
  policy = "${data.aws_iam_policy_document.lambda_edge.json}"
}
*/