require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe 'relationships' do
    it {should belong_to :user}
    it {should have_many(:friends)}
  end
end