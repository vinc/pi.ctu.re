json.array! @user.followees.map do |followee|
  json.extract! followee, :username
  json.url user_url(followee, format: :json, locale: nil)
end
