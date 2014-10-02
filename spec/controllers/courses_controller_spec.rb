require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe 'GET index' do
    context 'when user is logged in' do
      before(:each) do
        admin = create(:admin)
        session[:admin_id] = admin.id
      end

      it 'assigns @courses' do
        course = create(:course)
        get :index
        expect(assigns(:courses)).to include(course)
      end

      it 'has a 200 status code' do
        get :index
        expect(response.status).to eq(200)
      end

      it 'renders the index template'
    end

    context 'when user is not logged in' do
      it 'renders login template'
    end
  end
end
