class Api::V1::BidsController < Api::V1::BaseController

  def next
    @project = Project.find(params[:project_id])
    @bid = @project.bids.first_or_create!(user: current_user)
    @bid.next_state!
    render :show, status: :accepted
  end

  def cancel
    @project = Project.find(params[:project_id])
    @bid = @project.bids.where(user: current_user).first
    raise ActiveRecord::RecordNotFound if @bid.nil?
    @bid.cancel_state!
    render :show, status: :accepted
  end

  protected

  def bid_params
    params.require(:bid).permit(:price, :code)
  end

end