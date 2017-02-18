class ApplicationUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :postgresql_lo

  def path
    "/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def url
    "#{asset_host}#{path}/#{identifier}.jpg"
  end

  def extension_whitelist
    %w(jpg jpeg)
  end

  def content_type_whitelist
    'image/jpeg'
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  #def filename
  #  if original_filename
  #    if model && model.read_attribute(mounted_as).present?
  #      model.read_attribute(mounted_as)
  #    else
  #      "#{secure_token}.#{file.extension.downcase}" if original_filename.present?
  #    end
  #  end
  #end

  def thumb_url(geometry)
    "#{asset_host}#{path}/#{geometry}/#{identifier}.jpg"
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

  # HACK: carrierwave-postgres always make a oid, even when nothing has been
  # uploaded, so we can't just test if oid is nil, we have to read the file.
  # We override `empty?` and `blank?` to be able to do `attribute?`.
  def empty?
    length.zero?
  end

  alias :blank? :empty?

  private

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid.tr('-', ''))
  end
end
