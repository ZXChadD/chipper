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
    before :each do
      @tweet = create(:tweet, body: "law")
    end
    context "valid attributes" do
      it "located the requested @tweet" do
        put :update, params: { id: @tweet }, tweet: FactoryGirl.attributes_for(:tweet)
        assigns(:tweet).should eq(@tweet)
    end
       it "changes the contact's attributes" do
         put :update, params: { id: @tweet }, tweet: FactoryGirl.attributes_for(:tweet, body: 'edit body')
         @tweet.reload
         @tweet.body.should eq 'edit body'
       end
       it "redirects to the updated content" do
         put :update, params: { id: @tweet }, tweet: FactoryGirl.attributes_for(:tweet)
         reponse.should redirect_to @tweet
       end
     end
   end
 end
