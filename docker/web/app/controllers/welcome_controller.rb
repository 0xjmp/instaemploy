class WelcomeController < ApplicationController
  respond_to :html

  skip_before_filter :authenticate_user_from_token!
  skip_before_filter :authenticate_user!

  def index
    if user_signed_in?
      redirect_to "/explore" and return
    end
  end

end