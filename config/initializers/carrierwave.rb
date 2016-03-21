CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region: 'ap-northeast-1'
  }
  # clouffront
  cloud_front_url = "https://img.learntecs.xyz/"
  case Rails.env
    when 'production'
      config.fog_directory = 'api-img/pro'
      config.asset_host = cloud_front_url + "pro"
    when 'development'
      config.fog_directory = 'api-img/dev'
      config.asset_host = cloud_front_url + "dev"
    when 'test'
      config.fog_directory = 'api-img/test'
      config.asset_host = cloud_front_url + "test"
  end
end
#source = Tinify.from_file(img)

#resized = source.resize(
#  method: "fit",
#  width: 300,
#  height: 300
#)
#resized.store(
#  service: "s3",
#  aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
#  aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
#  region: "ap-northeast-1",
#  path: ENV["S3_BUCKET_PATH"] + path
#)
