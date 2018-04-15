json.extract! picture, :token, :caption, :image, :created_at
json.url picture_url(picture, format: :json, locale: nil)
json.author do
  json.username picture.user.username
  json.url user_url(picture.user, format: :json, locale: nil)
end
