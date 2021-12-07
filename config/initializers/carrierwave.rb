require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production? # 本番環境の場合はS3へアップロード
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'camp-hood' # バケット名
    config.fog_public = false
    config.fog_credentials = {
      provider: 'aws',
      aws_access_key_id: Rails.application.credentials.dig(:aws, :aws_access_key_id), # アクセスキー
      aws_secret_access_key: Rails.application.credentials.dig(:aws, :aws_secret_access_key), # シークレットアクセスキー
      region: 'ap-northeast-1', # リージョン
      path_style: true
    }
  else # 本番環境以外の場合はアプリケーション内にアップロード
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end
