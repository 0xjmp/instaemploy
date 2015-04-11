require 'spec_helper'

describe Api::V1::ProjectsController do
  let(:project){create(:project)}

  shared_examples 'shared suite' do
    it '#index' do
      get :index
      expect(response).to have_http_status 200
      expect(assigns(:projects)).to be
      expect(response).to render_template('index')
    end

    it '#show' do
      get :show, id: project.id, format: :json
      expect(response).to have_http_status 200
      expect(assigns(:project)).to be
      expect(response).to render_template('show')
    end

    context '#follow' do
      it 'should follow' do
        put :follow, project_id: project.id, format: :json
        expect(response).to have_http_status 202

        @user.reload
        expect(@user.points).to eq 10
      end
      it 'should unfollow' do
        @user.add_points 10
        @user.save!

        delete :unfollow, project_id: project.id, format: :json
        expect(response).to have_http_status 202

        @user.reload
        expect(@user.points).to eq 0
      end
    end
  end

  context 'while logged in' do
     context 'and authorized' do
      user_mapping(:senior)

      include_examples 'shared suite'

      it '#create' do
        post :create, project: attributes_for(:project), format: :json
        expect(response).to have_http_status 201
        expect(assigns(:project)).to be
        expect(response).to render_template('show')

        @user.reload
        expect(@user.points).to eq 250
      end

      it '#update' do
        newProject = attributes_for(:project)
        newProject['is_accepted'] = true

        put :update, id: project.id, project: newProject, format: :json
        expect(response).to have_http_status 200
        expect(response).to render_template('show')

        project = assigns(:project)
        expect(project).to be
        expect(project.is_accepted).to be true
      end

      it '#destroy' do
        @user.add_points 250
        @user.save!

        delete :destroy, id: project.id, format: :json
        expect(response).to have_http_status 204
        expect(assigns(:project)).to_not be

        @user.reload
        expect(@user.points).to eq 0
      end
    end

    context 'and not authorized' do
      user_mapping(:user)

      include_examples('shared suite')

      it '#create' do
        post :create, project: attributes_for(:project), format: :json
        expect(response).to have_http_status :forbidden
        expect(assigns(:project)).to_not be
      end

      it '#update' do
        put :update, id: project.id, project: attributes_for(:project), format: :json
        expect(response).to have_http_status :forbidden
        expect(assigns(:project)).to_not be
      end

      it '#destroy' do
        delete :destroy, id: project.id, format: :json
        expect(response).to have_http_status :forbidden
      end
    end
  end
end