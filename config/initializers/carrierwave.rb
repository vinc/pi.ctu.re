CarrierWave.configure do |config|
  config.asset_host = ENV["PICTURE_DELIVERY_URL"]
end
