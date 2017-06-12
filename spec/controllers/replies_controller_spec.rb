require 'rails_helper'

RSpec.describe RepliesController, type: :controller do
  let(:user) { create(:user) }
  let!(:tweet) { create(:tweet) }

  before { sign_in user }

  describe 'GET #new' do
    before do
      get :new, params: { tweet_id: tweet }
    end

    it { expect(assigns(:reply)).to be_new_record }
  end

  describe 'POST #create' do
    before do
      post :create, params: { reply: attributes, tweet_id: tweet }
    end

    context 'when user save passes' do
      let(:attributes) { attributes_for(:reply) }
      it { expect(response).to redirect_to tweets_path }
    end
  end
end
