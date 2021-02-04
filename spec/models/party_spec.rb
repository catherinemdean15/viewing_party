require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'relationships' do
    it { should belong_to :movie }
    it { should have_many(:parties_users) }
    it { should have_many(:users).through(:parties_users) }
  end
end
