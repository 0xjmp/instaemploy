require 'spec_helper'

describe Api::V1::BidsController do
  let(:project){create(:project)}
  let(:bid){create(:bid, project: project)}

  context 'while logged in' do
    user_mapping(:user)

    it '#next' do
      bid.user = @user
      bid.save!

      put :next, project_id: project.id, format: :json
      expect(assigns(:bid).state).to eq 'started'

      @user.reload
      expect(@user.points).to eq 100
    end

    it '#cancel' do
      @user.add_points 100
      bid.user = @user
      bid.save!

      bid.next_state!
      put :cancel, project_id: project.id, format: :json
      expect(assigns(:bid).state).to eq 'incomplete'

      @user.reload
      expect(@user.points).to eq 0
    end
  end
end