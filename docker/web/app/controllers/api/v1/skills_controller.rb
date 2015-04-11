class Api::V1::SkillsController < Api::V1::BaseController

  def show
    @projects = Project.by_skill(params[:name])
  end

end