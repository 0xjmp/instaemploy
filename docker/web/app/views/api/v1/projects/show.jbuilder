json.project do
  json.partial! 'api/v1/projects/project', project: @project, as: :project
  json.following @project.following?(current_user)
end