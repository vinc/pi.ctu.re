class ImageUploader < ApplicationUploader
  def path
    "/#{model.class.to_s.underscore}/#{mounted_as}/#{model.token}"
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

  process :store_dimensions

  private

  def store_dimensions
    if file && model
      img = MiniMagick::Image.open(file.file)
      model.width = img.width
      model.height = img.height
    end
  end
end
