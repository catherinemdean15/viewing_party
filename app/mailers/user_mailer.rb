class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'https://stormy-bastion-67887.herokuapp.com/'
    mail(to: @user.email, subject: 'Welcome to Viewing Party')
  end

  def party_host_email(party)
    @hosts = party.host
    @guests = party.guests
    @movie_title = party.movie.title
    @party = party
    @hosts.each do |host| 
      mail(to: host.email, subject: 'Viewing Party details')
    end
  end

  def party_guests_email(party)
    @host = party.host.first
    @guests = party.guests
    @movie_title = party.movie.title
    @party = party
    @guests.each do |guest|
      mail(to: guest.email, subject: 'You are invited to Viewing Party')
    end
  end
end
