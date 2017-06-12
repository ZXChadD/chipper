require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET #home' do
    it { expect(response).to be_successful }
  end

  describe 'GET #index' do
    let!(:tweets) { create_list(:tweet, 1, user: user) }
    before do
      get :index
    end

    it { expect(assigns(:tweets)).to eq(tweets) }
  end

  # describe 'GET #new' do
  #   before do
  #     get :new
  #   end
  #
  #   it {expect(assigns(:tweet)).to be_new_record}
  #
  # end

  describe 'POST #create' do
    before do
      post :create, xhr: true, params: { tweet: attributes }
    end
    context 'when user create passes' do
      let(:attributes) { attributes_for(:tweet) }
      it { expect(response).to render_template(:create) }
    end

    context 'when user create fails' do
      let(:attributes) { attributes_for(:tweet, :invalid) }
      it { expect(response).to render_template(:create) }
    end
  end

  describe 'DELETE #destroy' do
    let(:tweet) { create(:tweet) }
    before { delete :destroy, params: { id: tweet } }

    it { is_expected.to redirect_to tweets_path }
    it { expect(Tweet.count).to eq(0) }
  end

  describe 'PUT #update' do
    let!(:tweet) { create(:tweet) }

    it 'updates an item with valid params' do
      put :update, params: { id: tweet, tweet: { body: 'new body' } }
      tweet.reload
      expect(tweet.body).to eq('new body')
    end
    it 'updates an item with invalid params' do
      put :update, params: { id: tweet, tweet: { body: '' } }
      tweet.reload
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #upvote' do
    let!(:tweet){ create(:tweet) }
    before do
      post :upvote, params: {}

    it 'when user create a new like' do
      post :upvote
    end

  end
end
