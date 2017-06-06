require 'rails_helper'

RSpec.describe RepliesController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET #new' do
    let!(:tweet) { create(:tweet) }

    before do
      get :new,  params: { tweet_id: tweet }
    end

    it {expect(assigns(:reply)).to be_new_record}
  end
end
