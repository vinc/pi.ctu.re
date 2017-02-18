class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.token}"
  end

  process :store_dimensions

  version :square do
    process resize_to_fill: [300, 300]
  end

  def extension_whitelist
    %w(jpg jpeg)
  end

  def content_type_whitelist
    'image/jpeg'
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    if original_filename
      if model && model.read_attribute(mounted_as).present?
        model.read_attribute(mounted_as)
      else
        "#{secure_token}.#{file.extension.downcase}" if original_filename.present?
      end
    end
  end

  def thumb_url(geometry)
    model.image_url.split('/').insert(7, geometry).join('/')
  end

  # Example with a 600x400 picture: thumb_size('x200') -> '300x200'
  def thumb_size(geometry)
    w, _, h = geometry.partition('x')

    if h.present?
      h = h.to_i
      w = model.width * h / model.height
    elsif w.present?
      w = w.to_i
      h = model.height * w / model.weigth
    else
      return
    end

    [w, h].join('x')
  end

  private

  def store_dimensions
    if file && model
      img = MiniMagick::Image.open(file.file)
      model.width = img.width
      model.height = img.height
    end
  end

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid.tr('-', ''))
  end
end
