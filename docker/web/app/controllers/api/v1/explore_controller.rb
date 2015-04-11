class Api::V1::ExploreController < Api::V1::BaseController

  skip_before_filter :authenticate_user!

  def index
    @projects = Project.popular
  end

end