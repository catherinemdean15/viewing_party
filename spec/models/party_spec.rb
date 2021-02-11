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

  describe 'instance methods' do 
    before :each do 
      @user = User.create!(email: 'test5@gmail.com', password: 'test5test5')

      @friend_1 = User.create!(email: 'friend1@email.com', password: 'password')
      @friend_2 = User.create!(email: 'friend2@email.com', password: 'password')
      @friend_3 = User.create!(email: 'friend3@email.com', password: 'password')
  
      @movie_1 = Movie.create!(title: 'Mulan', run_time: '1 hour 12 min')
      @party_1 = @movie_1.parties.create!(start_time: '3:00 PM', date: '20/12/12', duration: 112)

      PartiesUser.create!(party_id: @party_1.id, user_id: @user.id, host: true)
      PartiesUser.create!(party_id: @party_1.id, user_id: @friend_1.id, host: false)
      PartiesUser.create!(party_id: @party_1.id, user_id: @friend_2.id, host: false)
      PartiesUser.create!(party_id: @party_1.id, user_id: @friend_3.id, host: false)
    end

    it "host" do 
      expect(@party_1.host).to eq([@user])
    end

    it "guests" do 
      expect(@party_1.guests).to include(@friend_3)
      expect(@party_1.guests).to include(@friend_2)
      expect(@party_1.guests).to include(@friend_1)
    end
  end
end
