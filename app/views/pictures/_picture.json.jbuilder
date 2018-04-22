json.extract! picture, :created_at, :status, :token
json.url picture_url(picture, format: :json, locale: nil)
json.extract! picture, :caption, :image
json.author do
  json.username picture.user.username
  json.url user_url(picture.user, format: :json, locale: nil)
end
