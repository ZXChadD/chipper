require 'rails_helper'
RSpec.describe User, type: :model do
  it { should have_many(:tweets) }
  it { should have_many(:replies) }
  it { should have_many(:likes) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }

  describe 'validates uniqness of email' do
    subject { User.create(username: 'abcdef', email: 'example@email.com', password: '123456') }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe 'validates uniqness of username' do
    subject { User.create(username: 'abcdef', email: 'example@email.com', password: '123456') }
    it { should validate_uniqueness_of(:username).case_insensitive }
  end
end
