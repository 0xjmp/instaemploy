class ApplicationController < ActionController::Base
  respond_to :html, :json

  include DateHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_filter :authenticate_user_from_token!
  before_filter :authenticate_user!

  def index
  end

  private

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) << permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << permitted_parameters
  end

  def permitted_parameters
    [
      :first_name,
      :last_name,
      :hireable,
      :company,
      :location,
      :avatar,
      :remove_avatar_url,
      :github_profile_url,
      :language_list,
      :username,
      :full_name
    ]
  end

  def after_sign_in_path_for(resource)
    session["user_return_to"] || root_path
  end

  def after_sign_up_path_for(resource)
    session["user_return_to"] || root_path
  end

  def authenticate_user_from_token!
    email = params[:email].presence
    user = email && User.find_by_email(email)

    if user && Devise.secure_compare(user.auth_token, params[:auth_token])
      sign_in user, store: false
    end
  end
end
