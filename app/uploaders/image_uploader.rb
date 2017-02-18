class ImageUploader < ApplicationUploader
  def path
    "/#{model.class.to_s.underscore}/#{mounted_as}/#{model.token}"
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
