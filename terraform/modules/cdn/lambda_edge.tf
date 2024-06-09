/*data "archive_file" "lambda_edge" {
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
  provider = aws.use1
}

data "aws_iam_role" "lambda_edge" {
  name = var.lambda_edge_iam_role
  provider = aws.use1
}
*/