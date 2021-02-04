require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe 'relationships' do
    it { should belong_to :friend1 }
    it { should belong_to :friend2 }
  end
end
