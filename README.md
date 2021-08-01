# Introduce
Learn terraform

# Variable
We can define variable with syntax:
```variable "name" {}
```
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