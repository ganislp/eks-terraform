
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
      variable = "system:serviceaccount:kube-system:ebs-csi-controller-sa"
    }

  }

}
resource "aws_iam_policy" "ebs_cis_iam_policy" {
  name        = "AmazonEKS_EBS_CSI_Driver_Policy"
  path        = "/"
  description = "EBS CSI IAM Policy"
  policy      = data.http.ebs_cis_iam_policy.body
}

output "ebs_cis_iam_policy_arn" {
  value = aws_iam_policy.ebs_cis_iam_policy.arn
}

resource "aws_iam_role" "ebs_cis_iam_role" {
  name               = "ebs_csi_iam_role"
  assume_role_policy = data.aws_iam_policy_document.iam_policy_document.json
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_att" {
  role       = aws_iam_role.ebs_cis_iam_role.name
  policy_arn = aws_iam_policy.ebs_cis_iam_policy.arn
}

output "ebs_csi_iam_role_arn" {
  description = "EBS CSI IAM Role ARN"
  value       = aws_iam_role.ebs_cis_iam_role.arn
}
