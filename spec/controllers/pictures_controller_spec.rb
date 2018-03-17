require 'rails_helper'

RSpec.describe PicturesController, type: :controller do

  describe 'GET #show' do
    context 'when picture exists' do
      it 'returns http success' do
        picture = FactoryBot.create(:picture)
        get :show, params: { token: picture.token }
        expect(response).to have_http_status(:success)
      end
    end

    context 'when picture does not exists' do
      it 'throws ActiveRecord::RecordNotFound' do
        expect {
          get :show, params: { token: 'invalid' }
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

end
