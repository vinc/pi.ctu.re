class AvatarUploader < ApplicationUploader
  def path
    "/#{model.class.table_name}/#{model.username}"
  end

  process resize_to_fit: [500, 500]
end
