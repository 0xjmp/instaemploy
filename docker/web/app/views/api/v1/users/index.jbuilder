json.user do
  json.partial! 'api/v1/users/current_user', user: @user, as: :user
end