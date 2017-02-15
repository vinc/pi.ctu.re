require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #show' do
    context 'when user exists' do
      it 'returns http success' do
        user = FactoryGirl.create(:user)
        get :show, params: { username: user.username }
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect {
          get :show, params: { username: 'invalid' }
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

end
