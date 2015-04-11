class Api::V1::SearchController < Api::V1::BaseController
  skip_before_filter :authenticate_user!

  def show
    @users = User.search(params[:query])
    @projects = Project.search(params[:query])
  end

end