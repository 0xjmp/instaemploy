class Api::V1::BaseController < ApplicationController
  respond_to :json

  def generic_error(errors)
    render status: :bad_request, json: {
      errors: errors.full_messages
    }
  end

  # action: a string describing what action IS NOT allowed
  def unauthorized_error(action)
    render status: :forbidden, json: {
      errors: "You are not allowed to #{action}"
    }
  end

end