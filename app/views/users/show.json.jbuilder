json.extract! @user, :username, :fullname, :created_at
json.url user_url(@user, format: :json, locale: nil)
json.links do
  json.followers followers_user_url(@user, format: :json, locale: nil)
  json.followees followees_user_url(@user, format: :json, locale: nil)
  json.albums user_albums_url(@user, format: :json, locale: nil)
  json.pictures user_pictures_url(@user, format: :json, locale: nil)
end
