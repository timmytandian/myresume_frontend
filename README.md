# myresume_frontend
This repository contains codes for the frontend part of The Cloud Resume Challenge, a static website hosted in cloud that showcases my resume. This repository includes the static website files and the infrastructure required to host and deliver the static website using Amazon S3.

## Architecture Diagram

<img alt="AWS Cloud Resume Diagram" src="./readme_media/aws-cloud-resume-diagram-en.jpg">

## Code Contents

### 1. Infrastructure Code
The Infrastructure as Code is implemented with Terraform.
1. **Static website Module**: Terraform code to create an S3 bucket for hosting the static website.
2. **Content Delivery Network (CDN) Module**: Terraform code to set up a CloudFront for caching and fast delivery of content.
3. **Domain Name System (DNS) Module**: Terraform code to configure a custom domain (using Route53) and SSL certificate for the website.

### 2. Static Website Files
1. **HTML, CSS, JS, Images**: The frontend files for the website.

### 3. Testing Code
1. Script to test the JavaScript functionality using `jest`.
2. Script to validate HTML using `gulp`

### 4. CI/CD Implementation
1. **GitHub Actions Workflow**: A workflow file (.yml) to automate the deployment process, including infrastructure provisioning and website content updates.

## Directory Structure Overview
```
/myresume_backend
├── .github/
│   └── workflows/
│       └── test_deploy.yml      (Code Content 4-1)
├── src/                         (Code Content 2-1)
│   ├── css/
│   ├── images/
│   ├── js/
│   └── index.html
├── terraform/
│   ├── environments/
│   │   ├── dev/
│   │   │   ├── main.tf
│   │   │   └── ...
│   │   └── prod/
│   │       └── main.tf
│   │       └── ...
│   └── modules/
│       ├── cdn/                 (Code Content 1-2)
│       │   └── ...
│       ├── dns/                 (Code Content 1-3)
│       │   └── ...
│       └── static_web/          (Code Content 1-1)
│           └── ...
├── gulpfile.js                  (Code Content 3-2)
├── __tests__/
│   └── index.test.js            (Code Content 3-1)
│
└── ...(other repo files)
```

## How to Use

### Prerequisites
- Terraform installed on your local machine.
- AWS CLI configured with proper credentials and permissions.
- Custom domain name registered in Route 53.
- GitHub repository configured with proper permissions.
- NodeJS (I'm using version 21.6).

### Deployment Steps
1. Navigate to the `[prod|dev]` directory under the Terraform environment directory. If you are using the `prod` branch go to the `prod` directory, otherwise use the `dev` branch.
2. Initialize Terraform: `terraform init`
3. Plan the deployment: `terraform plan`
4. Apply the deployment: `terraform apply`
5. Configure GitHub Actions:
   - Ensure the workflow file (`.github/workflows/test_deploy.yml`) is correctly set up.
   - Push changes to the `dev` or `prod` branch to trigger the CI/CD pipeline.