json.user do
  json.partial! 'api/v1/users/user', user: @user, as: :user
  json.projects do
    json.recent @user.recent_projects, partial: 'api/v1/projects/project', as: :project
    json.popular @user.popular_projects, partial: 'api/v1/projects/project', as: :project
    json.interesting @user.interesting_projects, partial: 'api/v1/projects/project', as: :project
  end
end