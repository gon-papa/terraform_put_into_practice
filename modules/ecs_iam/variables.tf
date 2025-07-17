variable "env" {
  type        = string
  description = "環境"
}

variable "project" {
  type        = string
  description = "プロジェクト名"
}

variable "session_parameter_arn" {
  type        = string
  description = "環境変数取得のためのセッションマネージャーのARN"
}
