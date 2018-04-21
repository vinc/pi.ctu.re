json.extract! album, :token, :title, :created_at
json.url album_url(album, format: :json, locale: nil)
json.author do
  json.username album.user.username
  json.url user_url(album.user, format: :json, locale: nil)
end
json.links do
  json.pictures album_pictures_url(album, format: :json, locale: nil)
end
