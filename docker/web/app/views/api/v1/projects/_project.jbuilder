json.(project, :id, :title, :description, :due_date, :is_available, :created_at, :views, :skills, :is_accepted)
json.state project.current_state(current_user)
json.user do
  if project.user
    json.partial! 'api/v1/users/user', user: project.user, as: :user
  end
end