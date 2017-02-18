CarrierWave.configure do |config|
  if Rails.env.production?
    config.asset_host = 'http://infra.stru.ctu.re';
  else
    config.asset_host = 'http://localhost:4000';
  end
end
