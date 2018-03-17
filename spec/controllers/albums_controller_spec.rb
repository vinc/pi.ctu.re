require 'rails_helper'

RSpec.describe AlbumsController, type: :controller do

  describe 'GET #show' do
    context 'when album exists' do
      it 'returns http success' do
        album = FactoryBot.create(:album)
        get :show, params: { token: album.token }
        expect(response).to have_http_status(:success)
      end
    end

    context 'when album does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect {
          get :show, params: { token: 'invalid' }
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

end
