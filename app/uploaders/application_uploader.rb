class ApplicationUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :postgresql_lo

  def path
    "/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def url
    "#{asset_host}#{path}/#{filename}"
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

  def filename
    key = "#{mounted_as}_filename".to_sym
    model.read_attribute(key)
  end

  def thumb_url(geometry)
    "#{asset_host}#{path}/#{geometry}/#{filename}"
  end

  # HACK: carrierwave-postgres always make a oid, even when nothing has been
  # uploaded, so we can't just test if oid is nil, we have to read the file.
  # We override `empty?` and `blank?` to be able to do `attribute?`.
  def empty?
    length.zero?
  end

  alias :blank? :empty?

  process :generate_filename

  def generate_filename
    key = "#{mounted_as}_filename".to_sym
    val = "#{SecureRandom.uuid.tr('-', '')}.jpg"
    model.write_attribute(key, val)
  end
end
