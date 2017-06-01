require 'rails_helper'
  RSpec.describe Tweet, type: :model do
    it{should belong_to(:user)}
    it{should have_many(:replies)}
    it{should validate_presence_of(:body)}
  end