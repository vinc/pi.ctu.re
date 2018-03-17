CarrierWave.configure do |config|
  config.asset_host = if Rails.env.production?
                        "https://infra.stru.ctu.re"
                      else
                        "http://localhost:4000"
                      end
end
