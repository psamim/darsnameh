require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET index' do
    context 'when user is logged in' do
      before do
        admin = create(:admin)
        session[:admin_id] = admin.id
        get :index
      end

      it 'assigns @courses' do
        course = create(:course)
        expect(assigns(:courses)).to include(course)
      end

      it 'has a success status code' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not logged in' do
      before do
        get :index
      end

      it 'redirects to login page' do
        expect(response).to redirect_to(:login)
      end
    end
  end
end
