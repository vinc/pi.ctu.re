class ImageUploader < ApplicationUploader
  def path
    "/#{model.class.to_s.underscore}/#{mounted_as}/#{model.token}"
  end

  # Example with a 600x400 picture: thumb_size('x200') -> '300x200'
  def thumb_size(geometry)
    w, _, h = geometry.partition("x")

    if h.present?
      h = h.to_i
      w = model.image_width * h / model.image_height
    elsif w.present?
      w = w.to_i
      h = model.image_height * w / model.image_weigth
    else
      return
    end

    [w, h].join("x")
  end

  process :store_dimensions

  private

  def store_dimensions
    if file && model
      image = MiniMagick::Image.open(file.file)
      model.image_width = image.width
      model.image_height = image.height
    end
  end
end
