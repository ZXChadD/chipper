require 'rails_helper'
  RSpec.describe Reply, type: :model do
    it{should belong_to(:tweet)}
  end
