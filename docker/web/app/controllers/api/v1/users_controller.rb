class Api::V1::UsersController < Api::V1::BaseController
  skip_before_filter :authenticate_user!, only: [:show]

  def index
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes!(user_params)
    render :show, status: :accepted
  end

  protected

  def user_params
    params.require(:user).permit(:email, :full_name, :first_name, :last_name, :username, :avatar, :location, :company, :skill_list)
  end

end