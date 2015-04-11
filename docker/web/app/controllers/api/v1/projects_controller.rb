class Api::V1::ProjectsController < Api::V1::BaseController

  before_filter :authorized?, only: [:create, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    if @project.save
      @project.reload
      render :show, status: :created
    else
      generic_error(@project.errors)
    end
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes!(project_params)
    render :show
  end

  def destroy
    project = Project.find(params[:id])
    project.destroy!
    render status: :no_content, nothing: true
  end

  def follow
    @project = Project.find(params[:project_id])
    @project.follow!(current_user)
    render nothing: true, status: :accepted
  end

  def unfollow
    @project = Project.find(params[:project_id])
    @project.unfollow!(current_user)
    render nothing: true, status: :accepted
  end

  protected

  def project_params
    params.require(:project).permit(:title, :description, :repo_url, :due_date, :skill_list, :is_accepted)
  end

  def authorized?
    unless current_user.authorized?
      unauthorized_error("modify this project")
    end
  end

end