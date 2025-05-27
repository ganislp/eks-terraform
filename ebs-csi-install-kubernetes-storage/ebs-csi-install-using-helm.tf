resource "helm_release" "ebs_csi_driver" {
  name       = "ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  namespace  = "kube-system"
  depends_on = [ aws_iam_role_policy_attachment.iam_role_policy_att ]

set {
  name = "image.repository"
  value = "602401143452.dkr.ecr.us-east-1.amazonaws.com/eks/aws-ebs-csi-driver"
}

set {
  name = "controller.serviceAccount.create"
  value = "true"
}
set{
    name = "controller.serviceAccount.name"
    value = "ebs-csi-controller-sa"
}

set {
  name = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  value = "${aws_iam_role.ebs_cis_iam_role.arn}"
}

}