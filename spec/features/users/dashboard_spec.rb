require 'rails_helper'

RSpec.describe 'As an authenticated user', type: :feature do
  describe 'When I visit the user dashboard' do
    before(:each) do
      @user1  = User.create!(email: 'test@example.com', password: 'test', is_registered?: true)
      @user2  = User.create!(email: 'best@example.com', password: 'best', is_registered?: true)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      @user1.authenticate(@user1.password)   

      @misery = Movie.create!(title: 'Misery', run_time: 107, genre: 'Thriller/Horror')
      @secret = Movie.create!(title: 'Secret', run_time: 139, genre: 'Thriller/Horror')
      @party1 = Party.create!(movie_id: @misery.id, start_time: 'Sat, 16 Jan 2021 14:00:00 UTC +00:00', end_time: 'Sat, 16 Jan 2021 16:00:00 UTC +00:00')
      @party2 = Party.create!(movie_id: @secret.id, start_time: 'Fri, 15 Jan 2021 13:00:00 UTC +00:00', end_time: 'Fri, 15 Jan 2021 16:00:00 UTC +00:00')

      Friend.create!(user_id: @user2.id, friend_id: @user1.id)
      PartiesUser.create!(party_id: @party1.id, user_id: @user1.id, host: false)
      PartiesUser.create!(party_id: @party1.id, user_id: @user2.id, host: true)
      PartiesUser.create!(party_id: @party2.id, user_id: @user1.id, host: true)
      PartiesUser.create!(party_id: @party2.id, user_id: @user2.id, host: false)
    end

    it 'I see the viewing parties I am invited to with the movie title, date & time, & host status' do
      visit dashboard_user_path(@user1)

      expect(page).to have_content("Upcoming Parties")

      within("#friend-party-info-#{@party1.id}") do
        expect(page).to have_content(@misery.title)
        expect(page).to have_content('January 16, 2021 2:00 PM')
        expect(page).to have_content('Invited')
      end

      within("#my-party-info-#{@party2.id}") do
        expect(page).to have_content(@secret.title)
        expect(page).to have_content('January 15, 2021 1:00 PM')
        expect(page).to have_content('Hosting')
      end
    end
  end
end