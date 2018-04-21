json.array! @user.followers.map do |follower|
  json.extract! follower, :username
  json.url user_url(follower, format: :json, locale: nil)
end
