# ============================
# SSMパラメータの取得(環境変数)
# ============================
data "aws_ssm_parameter" "parameter" {
  name = "/${var.env}/${var.project}/parameter"
}

# ============================
# IAM ECSの起動をするための権限設定
# ============================

# 信頼ポリシー
data "aws_iam_policy_document" "ecs_task_exec_assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
      type = "Service"
    }
  }
}

# ECS起動時に操作する周辺サービスの実行ポリシーをAWSマネージドポリシーから取得
# "ecr:GetAuthorizationToken",
# "ecr:BatchCheckLayerAvailability",
# "ecr:GetDownloadUrlForLayer",
# "ecr:BatchGetImage",
# "logs:CreateLogStream",
# "logs:PutLogEvents"
data "aws_iam_policy" "ecs_task_exec_managed_policy" {
  name = "AmazonECSTaskExecutionRolePolicy"
}

# ECS起動時にSSMを操作するためのポリシー
data "aws_iam_policy_document" "ecs_task_exec_ssm_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameters",
      "ssm:GetParameter"
    ]
    resources = [
      data.aws_ssm_parameter.parameter.arn
    ]
  }
}

# IAMロールの作成
resource "aws_iam_role" "ecs_task_exec_role" {
  name               = "${var.env}-${var.project}-task-exec_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_exec_assume_role.json
}

# ロールにマネージドポリシーをアタッチ
resource "aws_iam_role_policy_attachments_exclusive" "ecs_exec_managed_policy" {
  policy_arns = [data.aws_iam_policy.ecs_task_exec_managed_policy.arn]
  role_name   = aws_iam_role.ecs_task_exec_role.name
}

# ロールにインラインポリソーをアタッチ
resource "aws_iam_role_policy" "ecs_exec_inline_policy" {
  name   = "${var.env}-${var.project}-ecs-exec-policy"
  policy = data.aws_iam_policy_document.ecs_task_exec_ssm_policy.json
  role   = aws_iam_role.ecs_task_exec_role.name
}

# ============================
# IAM ECSタスクロール(実行時権限)
# ============================

# 信頼ポリシー
data "aws_iam_policy_document" "ecs_task_assume_role" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
      type = "Service"
    }
  }
}

# タスクロールにアタッチするインラインポリシー
data "aws_iam_policy_document" "ecs_task" {
  statement {
    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessage:OpenControlChannel",
      "ssmmessage:OpenDataChannel"
    ]
    resources = ["*"]
  }
}

# タスクロール記述
resource "aws_iam_role" "ecs_task" {
  name               = "${var.env}-${var.project}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume_role.json
}

# タスクロールにインラインポリシーをアタッチ
resource "aws_iam_role_policy" "ecs_task_inline_policy" {
  name   = "${var.env}-${var.project}-ecs-task-policy"
  policy = data.aws_iam_policy_document.ecs_task.json
  role   = aws_iam_role.ecs_task.name
}
