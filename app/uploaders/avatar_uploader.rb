class AvatarUploader < ApplicationUploader
  def path
    "/#{model.class.to_s.underscore}/#{mounted_as}/#{model.username}"
  end

  process resize_to_fit: [500, 500]
end
