# ============================
# ECR(イメージレジストリ)
# ============================
resource "aws_ecr_repository" "repository" {
  name = "${var.env}-${var.project}-api"
}


# ============================
# SSM(環境変数の設定)
# ============================
resource "aws_ssm_parameter" "parameter" {
  name  = "/${var.env}/${var.project}/parameter"
  type  = "SecureString"
  value = "dummy"

  lifecycle {
    ignore_changes = [value]
  }
}
