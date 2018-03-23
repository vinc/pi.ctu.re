json.extract! @user, :username, :fullname, :created_at
json.url user_url(@user, format: :json)
