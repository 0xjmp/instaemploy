class Api::V1::AlertsController < Api::V1::BaseController

  def create
    @alert = Alert.create!(alert_params)
    render status: :accepted, json: {
      status: @alert.present?
    }
  end

  def destroy
    alert = Alert.find(params[:id])
    alert.destroy!
    render status: :no_content, nothing: true
  end

  protected

  def alert_params
    params.require(:alert).permit(:email, :skill_list)
  end

end