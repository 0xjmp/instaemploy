require 'omniauth'

module ControllerHelpers

  def user_mapping(type, oauth_type = :github)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @request.env["omniauth.auth"] = OmniAuth.config.mock_auth[oauth_type]
      sign_in @user = FactoryGirl.create(type)
    end
  end

  def user_types
    [:user, :senior, :admin]
  end
end