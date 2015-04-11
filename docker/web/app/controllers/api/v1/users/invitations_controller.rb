class Api::V1::Users::InvitationsController < Api::V1::BaseController

  before_filter :authorized?

  def create
    @invitation = current_user.invite!(invitation_params)
    flash[:success] = I18n.t("invitation.sent")
    render :show, status: :accepted
  end

  def update
    @invitation = Invitation.find(params[:id])
    @invitation.update_attributes!(invitation_params)
    flash[:success] = I18n.t("invitation.updated")
    render :show
  end

  def destroy
    invitation = Invitation.find(params[:id])
    invitation.destroy!
    flash[:notice] = I18n.t("invitation.deleted")
    render status: :no_content, nothing: true
  end

  def email_alert
    render status: :accepted, json: {
      success: Invitation.create_email_alert!(invitation_params)
    }
  end

  protected

  def invitation_params
    params.require(:invitation).permit(:sender_id, :invite_type, :email)
  end

  def authorized?
    unless current_user.authorized?
      unauthorized_error("invite users")
    end
  end

end