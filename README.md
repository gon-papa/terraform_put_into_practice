#　Terraformによるインフラ構築

## environments
環境ごとにディレクトリ分けを行った。
- dev
- qa
- prod
-shared
    - network(共通VPCのため、初めにterraform applyで反映しておく)
- backend(tfStateファイル管理S3+DynamoDB 本来、AWSアカウントごと分けるべきだが、同一アカウントにて作成)

