/*
data "archive_file" "lambda_edge_zip" {
  type        = "zip"
  output_path = "/tmp/lambda_edge.zip"
  source {
    content  = <<EOF
module.exports.handler = (event, context, callback) => {
	const request = event.Records[0].cf.request;
	request.uri = request.uri.replace(/^\/api/, "");

	callback(null, request);
};
EOF
    filename = "main.js"
  }
}

resource "aws_lambda_function" "lambda_edge" {
  function_name = "${random_id.id.hex}-edge-function"

  filename         = "${data.archive_file.lambda_edge_zip.output_path}"
  source_code_hash = "${data.archive_file.lambda_edge_zip.output_base64sha256}"

  handler = "main.handler"
  runtime = "nodejs10.x"
  role    = "${aws_iam_role.lambda_edge_exec.arn}"

  provider = aws.us_east_1
  publish  = true
}

data "aws_iam_policy_document" "lambda_edge_exec_role_policy" {
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

resource "aws_iam_role_policy" "lambda_edge_exec_role" {
  role   = "${aws_iam_role.lambda_edge_exec.id}"
  policy = "${data.aws_iam_policy_document.lambda_edge_exec_role_policy.json}"
}

resource "aws_iam_role" "lambda_edge_exec" {
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
*/
