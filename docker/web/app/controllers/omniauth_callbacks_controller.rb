class OmniauthCallbacksController < ApplicationController
  skip_before_filter :authenticate_user!

  def create
    @user = User.from_omniauth(request.env["omniauth.auth"])
    unless @user.blank?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      render status: 422, json: {
        errors: @user.errors.full_messages
      }
    end
  end

  def failure_message
    exception = env["omniauth.error"]
    error   = exception.error_reason if exception.respond_to?(:error_reason)
    error ||= exception.error        if exception.respond_to?(:error)
    error ||= env["omniauth.error.type"].to_s
    error.to_s.humanize if error
  end

end