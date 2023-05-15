resource "aws_iam_user" "my_user" {
  name = "github-action-1"
}

resource "aws_iam_policy" "my_user_policy" {
  name   = "github-action-policy"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
          "ecr:CreateRepository"
        ],
        "Resource": "*"
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "my_user_policy_attachment" {
  name       = "github-action-policy-attachment"
  users      = [aws_iam_user.my_user.name]
  policy_arn = aws_iam_policy.my_user_policy.arn
}

resource "aws_iam_access_key" "my_access_key" {
  user = aws_iam_user.my_user.name
}

