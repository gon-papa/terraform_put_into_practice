# ============================
# ECSクラスター
# ============================
resource "aws_ecs_cluster" "cluster" {
  name = "${var.env}-${var.project}-cluster"

  # モニタリングオプション
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "cluster" {
  capacity_providers = ["FARGATE"]
  cluster_name       = aws_ecs_cluster.cluster.name
}


