CarrierWave.configure do |config|
  if Rails.env.production?
    config.asset_host = 'http://infra.stru.ctu.re';
  else
    config.asset_host = 'http://localhost:4000';
  end
end

if Rails.env.test?
  Dir["#{Rails.root}/app/uploaders/*.rb"].each { |file| require file }
  if defined?(CarrierWave)
    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?

      klass.class_eval do
        def cache_dir
          "#{Rails.root}/spec/support/uploads/tmp"
        end

        def store_dir
          "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
      end
    end
  end
end
