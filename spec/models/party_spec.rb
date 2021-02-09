require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:duration) }
  end

  describe 'relationships' do
    it { should belong_to :movie }
    it { should have_many(:parties_users) }
    it { should have_many(:users).through(:parties_users) }
  end
end
