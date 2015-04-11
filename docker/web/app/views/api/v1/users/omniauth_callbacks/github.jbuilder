json.user do
  json.partial! 'api/v1/users/user', user: @user, as: :user
end