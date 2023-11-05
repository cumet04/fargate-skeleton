# fargate-skeleton
Fargateなwebアプリの環境のサンドボックスを作るためのスケルトン構成です

# 使い方

## AWSインフラ
infraディレクトリでterraform applyする。

下記terraform variableが必要。環境変数で入れる※
* `TF_VAR_name` 環境の名前。これをユニークにすると、同一AWSアカウント内に複数環境つくれる
* `TF_VAR_use_alb` 1にするとALB（とALBリスナー）が生成される。地味に費用が発生するので、デフォルトではOFF

※TF_VAR_nameはecspressoでも参照するため、環境変数で渡すようにしている

## appコンテナ
appディレクトリでdocker buildし、terraformで生成されたECRリポジトリにpushしておく

## ecspresso
ecspressoディレクトリでecspresso deployしたりする

# 片付け

## 全リソースを消す場合
* terraform管理でないリソースを消す
  * ECSサービス（`ecspresso delete`で消せる。これを消さないとECS Clusterが消せない）
  * ECRリポジトリに登録された全イメージ（手動で消す。これを消さないとリポジトリが消せない）
  * ECSタスク定義（消さなくても問題はない）
* `terraform destroy`でterraform配下のリソースを消す

## 一時的に料金発生を止める
次の週末にまた遊ぶ場合など、全ては消さずに料金だけ抑えたいとき

* `TF_VAR_use_alb`を指定せずにapplyする（ALBが消える）
* `ecspresso scale --tasks=0`でコンテナを止める
