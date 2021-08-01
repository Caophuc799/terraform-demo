{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": [
            "ec2:DescribeInstances", "ec2:DescribeImages",
            "ec2:DescribeTags", "ec2:DescribeSnapshots"
        ],
        "Resource": "${arn}"
    }
    ]
}