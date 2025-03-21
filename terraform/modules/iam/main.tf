resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ECSAssumeRole",
            "Effect": "Allow",
            "Principal": {
                "Service": "ecs-tasks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
  })
}

# Permissions policy that allows ECS task to access S3
resource "aws_iam_policy" "ecs_task_policy" {
  name        = "AmazonS3ReadOnlyAccess"
  description = "Policy to allow ECS task to access S3"

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*"
            ],
            "Resource": "arn:aws:s3:::aws-tf-back/*"
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "role-attach" {
    role = aws_iam_role.ecs_task_role.name
    policy_arn = aws_iam_policy.ecs_task_policy.arn
  
}