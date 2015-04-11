require 'spec_helper'

describe Api::V1::Users::InvitationsController do
  let(:invitation){create(:invitation)}

  describe 'while logged in' do

    context 'and authorized' do
      user_mapping(:senior)

      for type in user_types
        context "and inviting #{type}" do
          it '#create' do
            attributes = attributes_for(:invitation)
            attributes[:invite_type] = type
            post :create, invitation: attributes
            expect(response).to render_template('show')
            expect(assigns(:invitation)).to be
            expect(response).to have_http_status :accepted

            @user.reload
            expect(@user.points).to eq 500
          end
        end
      end

      it '#update' do
        put :update, id: invitation.id, invitation: attributes_for(:invitation)
        expect(response).to render_template('show')
        expect(assigns(:invitation)).to be
        expect(response).to have_http_status 200
      end

      it '#destroy' do
        @user.add_points 500
        @user.save!

        delete :destroy, id: invitation.id
        expect(response).to have_http_status 204
        expect(assigns(:invitation)).to_not be

        @user.reload
        expect(@user.points).to eq 0
      end
    end

    context 'and not authorized' do
      user_mapping(:user)

      for type in user_types
        context "and inviting #{type}" do
          it '#create' do
            attributes = attributes_for(:invitation)
            attributes[:invite_type] = type
            post :create, invitation: attributes
            expect(response).to have_http_status :forbidden
            expect(assigns(:invitation)).to_not be
          end
        end
      end

      it '#update' do
        put :update, id: invitation.id, invitation: attributes_for(:invitation)
        expect(response).to have_http_status :forbidden
        expect(assigns(:invitation)).to_not be
      end

      it '#destroy' do
        delete :destroy, id: invitation.id
        expect(response).to have_http_status :forbidden
      end
    end
  end
end