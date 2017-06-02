require 'rails_helper'

RSpec.describe TweetsController, type: :controller do

  let(:user) { create(:user) }
  before { sign_in user }

  describe 'GET #index' do
    let!(:tweets){create_list(:tweet,1, user: user)}
    before do
      get :index
    end

    it { expect(assigns(:tweets)).to eq(tweets)}
  end

  describe 'GET #new' do
    before do
      get :new
    end

    it {expect(assigns(:tweet)).to be_new_record}

  end

  describe 'POST #create' do
    before do
      post :create, params: { tweet: params}
    end
    context 'when user save passes' do
      let(:params) {attributes_for(:tweet)}
      it {expect(response).to redirect_to tweets_path}
    end

    context 'when user save fails' do
      let(:params) {attributes_for(:tweet, :invalid)}
      it  {expect(response).to render_template(:new)}
    end
  end

  describe 'DELETE #destroy' do
    let(:tweet) {create(:tweet)}
    before { delete :destroy, params: { id: tweet } }

    it {is_expected.to redirect_to tweets_path}
    it {expect(Tweet.count).to eq(0)}
  end

  describe "PUT #update" do
    let!(:tweet) { create(:tweet) }

     it "updates an item with valid params" do
       put :update, params: { id: tweet, tweet: { body: "new body" } }
       tweet.reload
       expect(tweet.body).to eq("new body")
     end
     it "updates an item with invalid params" do
       put :update, params: { id: tweet, tweet: { body: "" } }
       tweet.reload
       expect(response).to render_template(:edit)
     end
   end
 end
