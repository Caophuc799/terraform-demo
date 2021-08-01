# Introduce
Learn terraform

# Variable
We can define variable with syntax:
```variable "name" {}```
We can use variable with syntax:
```${var.name}```
with Map: 
```${lookup(var.name, var.key)}```
## Define environment variable
export TF_VAR_aws_access_key=""

export TF_VAR_aws_secret_key=""

## Check environment variable
env | grep TF

## Override variable when apply
``` terraform plan -var target_env=prod```
## Define variable by command line when apply and destroy
```
terraform apply -var 'aws_region=us-west-1'
terraform destroy -var 'aws_region=us-west-1'
```

## output varriable
The result after apply

The way query: ```terraform output name_of_variable```

# Condition
condition ? true : false

example:
```
count = "${var.target_env == "dev" ? 0 : 1}"
```

# Template
```
data "template_file" "webserver_policy_template" {
    template = "${file("${path.module}/policy.tpl")}"

    vars = {
        arn = "${aws_instance.web_server.arn}"
    }
}
```

# Resource dependencies
Implicit
```
resource "aws_instance" "web_server" {
  ami = "${lookup(var.webserver_amis, var.aws_region)}"
  instance_type = "t2.micro" # free tier

  subnet_id = "${aws_default_subnet.demo_default_subnet.id}"
  # It depend on aws_default_subnet
  # It's going to create default subnet first
}
```
Explicit
```
depends_on = [
    aws_s3_bucket.demo-bins
  ]
```

# Module
Load module
```
module "demo_module" {
  source = "./web_server_module" # or "terraform-aws-modules/vpc/aws"
  # define variable which module use
}
```
https://registry.terraform.io/

# Import exist resource
We can import existed resource by command line:
If in aws, we have ec2, and we want to reuse it.
In terraform
```
resource "aws_instance" "web_server" {
  ami = "ami-0c2b8ca1dad447f8a" # match with existing ec2
  instance_type = "t2.micro" # match with existing ec2
}
```
Run command:
```
terraform import aws_instance.web_server i-xxxxxxxxx
```
We can check by command: ```terraform show```


# Remote state using s3
We can use remote state, It is really helpful when we work with teammate
We can create s3 bucket to store state
We should create terraform.tf with this code:
```
terraform {
  backend "s3" {
    bucket = "demo-state" # bucket name
    key = "demo-state/terraform.tfstate” # path in the bucket of s3 
    region = "us-east-1"
    profile = “default”
  }
}
```
After that, we run ```terraform init```


# Use aws credential with Aws terraform provider
Create ~/.aws/credentials if it does not exist. I suggest that we should use command: ```aws configure```
Run ```chmod 600 credentials```
```
provider "aws" {
  profile = "default"
  region = "${var.aws_region}"
}
````


