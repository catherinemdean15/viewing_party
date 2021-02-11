class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'https://stormy-bastion-67887.herokuapp.com/'
    mail(to: @user.email, subject: 'Welcome to Viewing Party')
  end

  def party_email_host(party)
    binding.pry
    @user = host
    @party = party
    @guest = guests
    mail(to: @user.email, subject: 'Viewing Party details')
  end

  def party_email_guests(host, guests, party_info)
    @user = host
    @guests = guests
    @party_info = party_info
    @guests.each do |guest|
      mail(to: guest.email, subject: 'You are invited to Viewing Party')
    end
  end
end
