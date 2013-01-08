CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['S3_ACCESS_KEY_ID'],
      :aws_secret_access_key  => ENV['S3_SECRET_ACCESS_KEY'],
      :region                 => 'eu-west-1',
    }
    config.fog_directory  = ENV['S3_BUCKET']
    config.fog_public     = false
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  else
    config.storage = :file
  end
end
