require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  before :each do 
    @user = User.create!(email: 'test5@gmail.com', password: 'test5test5')

    @friend_1 = User.create!(email: 'friend1@email.com', password: 'password')
    @friend_2 = User.create!(email: 'friend2@email.com', password: 'password')
    @friend_3 = User.create!(email: 'friend3@email.com', password: 'password')

    @movie_1 = Movie.create!(title: 'Mulan', run_time: '1 hour 12 min')
    @movie_2 = Movie.create!(title: 'Oceans 11', run_time: '2 hours 10 min')
    @party_1 = @movie_1.parties.create!(start_time: '3:00 PM', date: '20/12/12', duration: 112)
    @party_2 = @movie_2.parties.create!(start_time: '5:00 PM', date: '12/12/12', duration: 156)

    PartiesUser.create!(party_id: @party_1.id, user_id: @user.id, host: true)
    PartiesUser.create!(party_id: @party_1.id, user_id: @friend_1.id, host: false)
    PartiesUser.create!(party_id: @party_1.id, user_id: @friend_2.id, host: false)
    PartiesUser.create!(party_id: @party_1.id, user_id: @friend_3.id, host: false)
  end
  describe 'welcome_email' do

    let(:mail) { UserMailer.welcome_email(@user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Welcome to Viewing Party')
      expect(mail.to).to eq(['test5@gmail.com'])
      expect(mail.from).to eq(['joejviewingparty@gmail.com'])
    end

    it 'renders the body' do
      expect(mail.text_part.body.to_s).to include('You have successfully signed up to ViewingParty')
      expect(mail.text_part.body.to_s).to include("your username is: #{user.email}")

      expect(mail.html_part.body.to_s).to include('You have successfully signed up to ViewingParty')
      expect(mail.html_part.body.to_s).to include("your username is: #{user.email}")

      expect(mail.body.encoded).to include('You have successfully signed up to ViewingParty')
      expect(mail.body.encoded).to include("your username is: #{user.email}")
    end
  end

  describe 'party_email_host' do

    let(:mail) { UserMailer.party_email_host(@party_1)}

    it "renders the headers" do 
      expect(mail.subject).to eq('Welcome to Viewing Party')
      expect(mail.to).to eq(['test5@gmail.com'])
      expect(mail.from).to eq(['joejviewingparty@gmail.com'])
    end
  end
end