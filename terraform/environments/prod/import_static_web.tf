# Use the block below to import the resource from AWS

###################################################
# Bucket: main_static_website
###################################################

import {
	to = module.static_web.aws_s3_bucket.main_static_website
	id = "timmytandian.com" # the ID of the resource in the source platform
}

import {
	to = module.static_web.aws_s3_bucket_versioning.main_static_website
	id = "timmytandian.com" # the ID of the resource in the source platform
}

import {
	to = module.static_web.aws_s3_bucket_server_side_encryption_configuration.main_static_website
	id = "timmytandian.com" # the ID of the resource in the source platform
}

import {
	to = module.static_web.aws_s3_bucket_public_access_block.main_static_website
	id = "timmytandian.com" # the ID of the resource in the source platform
}

import {
	to = module.static_web.aws_s3_bucket_ownership_controls.main_static_website
	id = "timmytandian.com" # the ID of the resource in the source platform
}

import {
	to = module.static_web.aws_s3_bucket_acl.main_static_website
	id = "timmytandian.com,private" # the ID of the resource in the source platform
}

import {
	to = module.static_web.aws_s3_bucket_website_configuration.main_static_website
	id = "timmytandian.com" # the ID of the resource in the source platform
}

/*
data "aws_iam_policy_document" "main_static_website" {
  statement {
    actions = ["s3:GetObject","s3:GetObjectVersion"]
    sid    = "Allow only GET requests originating from CloudFront with specific Referer header"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    resources = [
      "${aws_s3_bucket.main_static_website.arn}/*",
    ]

    condition {
      test     = "StringNotLike" # should be "StringLike"
      variable = "aws:Referer"

      values = [
        "${var.referer_custom_header}"
      ]
    }
  }
}*/

import {
	to = module.static_web.aws_s3_bucket_policy.main_static_website
	id = "timmytandian.com" # the ID of the resource in the source platform
}
/*
locals {
  bucket_keys = [
    {
        obj = "timmytandian.com/css/styles.css"
    },
    {
        obj = "timmytandian.com/images/aws-certified-cloud-practitioner.png"
    },
    {
        obj = "timmytandian.com/images/aws-certified-solutions-architect-associate.png"
    },
    {
        obj = "timmytandian.com/images/favicon.ico"
    },
    {
        obj = "timmytandian.com/images/profpic.jpg"
    },
    {
        obj = "timmytandian.com/index.html"
    },
    {
        obj = "timmytandian.com/js/index.js"
    },
  ]
}

import {
	for_each = local.bucket_keys
    to = module.static_web.aws_s3_object.website_files.this[each.value.obj]
	id = each.value.obj
}*/
/*
import {
	to = module.static_web.aws_s3_object.website_files["timmytandian.com/css/styles.css"]
	id = "timmytandian.com/css/styles.css"
}*/

###################################################
# Bucket: subdomain_www_static_website
###################################################

import {
	to = module.static_web.aws_s3_bucket.subdomain_www_static_website
	id = "www.timmytandian.com" # the ID of the resource in the source platform
}

import {
	to = module.static_web.aws_s3_bucket_versioning.subdomain_www_static_website
	id = "www.timmytandian.com" # the ID of the resource in the source platform
}

import {
	to = module.static_web.aws_s3_bucket_server_side_encryption_configuration.subdomain_www_static_website
	id = "www.timmytandian.com" # the ID of the resource in the source platform
}

import {
	to = module.static_web.aws_s3_bucket_public_access_block.subdomain_www_static_website
	id = "www.timmytandian.com" # the ID of the resource in the source platform
}

import {
	to = module.static_web.aws_s3_bucket_ownership_controls.subdomain_www_static_website
	id = "www.timmytandian.com" # the ID of the resource in the source platform
}

import {
	to = module.static_web.aws_s3_bucket_website_configuration.subdomain_www_static_website
	id = "www.timmytandian.com" # the ID of the resource in the source platform
}