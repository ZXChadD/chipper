require 'rails_helper'
  RSpec.describe User, type: :model do
    it{should have_many(:tweets)}
    it{should have_many(:replies)}
    it{should validate_presence_of(:email)}

    describe 'validates uniqness of' do
      subject {User.create(email: 'example@email.com', password: '123')}
      it{should validate_uniqueness_of(:email).ignoring_case_sensitivity}
    end
  end
