require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  before :each do 
    @user = User.create!(email: 'test5@gmail.com', password: 'test5test5')

    @friend_1 = User.create!(email: 'friend1@email.com', password: 'password')
    @friend_2 = User.create!(email: 'friend2@email.com', password: 'password')
    @friend_3 = User.create!(email: 'friend3@email.com', password: 'password')

    @movie_1 = Movie.create!(title: 'Mulan', run_time: '1 hour 12 min')
    @movie_2 = Movie.create!(title: 'Oceans 11', run_time: '2 hours 10 min')
    @party_1 = @movie_1.parties.create!(start_time: '3:00 PM', date: '2020/12/12', duration: 112)
    @party_2 = @movie_2.parties.create!(start_time: '5:00 PM', date: '2012/12/12', duration: 156)

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
      expect(mail.text_part.body.to_s).to include("your username is: #{@user.email}")

      expect(mail.html_part.body.to_s).to include('You have successfully signed up to ViewingParty')
      expect(mail.html_part.body.to_s).to include("your username is: #{@user.email}")

      expect(mail.body.encoded).to include('You have successfully signed up to ViewingParty')
      expect(mail.body.encoded).to include("your username is: #{@user.email}")
    end
  end

  describe 'party_email_host' do
    let(:mail) { UserMailer.party_host_email(@party_1)}

    it "renders the headers" do 
      expect(mail.subject).to eq('Viewing Party details')
      expect(mail.to).to eq([@party_1.host.first.email])
      expect(mail.from).to eq(['joejviewingparty@gmail.com'])
    end

    it 'renders the body' do
      expect(mail.text_part.body.to_s).to include('You have successfully created a ViewingParty')
      expect(mail.text_part.body.to_s).to include("You will be watching #{@party_1.movie.title}")
      expect(mail.text_part.body.to_s).to include("Your party is on #{@party_1.date.strftime('%B %d, %Y')} at #{@party_1.start_time.strftime('%l:%M %p')}")
      expect(mail.text_part.body.to_s).to include(@party_1.guests[0].email)
      expect(mail.text_part.body.to_s).to include(@party_1.guests[1].email)
      expect(mail.text_part.body.to_s).to include(@party_1.guests[2].email)

      expect(mail.html_part.body.to_s).to include('You have successfully created a ViewingParty')
      expect(mail.html_part.body.to_s).to include("You will be watching #{@party_1.movie.title}")
      expect(mail.html_part.body.to_s).to include("Your party is on #{@party_1.date.strftime('%B %d, %Y')} at #{@party_1.start_time.strftime('%l:%M %p')}")
      expect(mail.html_part.body.to_s).to include(@party_1.guests[0].email)
      expect(mail.html_part.body.to_s).to include(@party_1.guests[1].email)
      expect(mail.html_part.body.to_s).to include(@party_1.guests[2].email)

      expect(mail.body.encoded).to include('You have successfully created a ViewingParty')
      expect(mail.body.encoded).to include("You will be watching #{@party_1.movie.title}")
      expect(mail.body.encoded).to include("Your party is on #{@party_1.date.strftime('%B %d, %Y')} at #{@party_1.start_time.strftime('%l:%M %p')}")
      expect(mail.body.encoded).to include(@party_1.guests[0].email)
      expect(mail.body.encoded).to include(@party_1.guests[1].email)
      expect(mail.body.encoded).to include(@party_1.guests[2].email)
    end
  end

  describe 'party_guests_email' do
    let(:mail) { UserMailer.party_guests_email(@party_1)}

    it "renders the headers" do 
      expect(mail.subject).to eq('You are invited to Viewing Party')
      expect(mail.to).to eq(['friend1@email.com'])
      expect(mail.from).to eq(['joejviewingparty@gmail.com'])
    end

    it 'renders the body' do
      expect(mail.text_part.body.to_s).to include("You are invited to a ViewingParty by #{@party_1.host.first.email}")
      expect(mail.text_part.body.to_s).to include("You will be watching #{@party_1.movie.title}")
      expect(mail.text_part.body.to_s).to include("Your party is on #{@party_1.date.strftime('%B %d, %Y')} at #{@party_1.start_time.strftime('%l:%M %p')}")

      expect(mail.html_part.body.to_s).to include("You are invited to a ViewingParty by #{@party_1.host.first.email}")
      expect(mail.html_part.body.to_s).to include("You will be watching #{@party_1.movie.title}")
      expect(mail.html_part.body.to_s).to include("Your party is on #{@party_1.date.strftime('%B %d, %Y')} at #{@party_1.start_time.strftime('%l:%M %p')}")

      expect(mail.body.encoded).to include("You are invited to a ViewingParty by #{@party_1.host.first.email}")
      expect(mail.body.encoded).to include("You will be watching #{@party_1.movie.title}")
      expect(mail.body.encoded).to include("Your party is on #{@party_1.date.strftime('%B %d, %Y')} at #{@party_1.start_time.strftime('%l:%M %p')}")
    end
  end
end