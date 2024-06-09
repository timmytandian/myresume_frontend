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

import {
	to = module.static_web.aws_s3_bucket_policy.main_static_website
	id = "timmytandian.com" # the ID of the resource in the source platform
}

import {
	for_each = fileset("../../../src/", "**/*.*")
  to = module.static_web.aws_s3_object.website_files[each.key]
	id = format("%s/%s","timmytandian.com",each.value)
}

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