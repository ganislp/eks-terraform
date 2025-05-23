data "aws_iam_policy" "s3ReadOnlyPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

data "aws_iam_policy_document" "iam_policy_document" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = ["${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_arn}"]

    }
    condition {
      test     = "StringEquals"
      values   = ["${data.terraform_remote_state.eks.outputs.aws_iam_openid_connect_provider_extract_from_arn}:sub"]
      variable = "system:serviceaccount:default:irsa-demo-sa"
    }

  }

}

resource "aws_iam_role" "irsa_iam_role" {
  name               = "irsa_iam_role"
  assume_role_policy = data.aws_iam_policy_document.iam_policy_document.json
}

resource "aws_iam_role_policy_attachment" "irsa_iam_role_attachment" {
  role       = aws_iam_role.irsa_iam_role.name
  policy_arn = data.aws_iam_policy.s3ReadOnlyPolicy.arn
}