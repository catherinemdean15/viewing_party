require 'rails_helper'

RSpec.describe 'As an authenticated user', type: :feature do
  describe 'When I visit the discover movies page' do
    before(:each) do
      @user = User.create!(email: 'test5@gmail.com', password: 'test5test5', is_registered?: true)
      @user.authenticate(@user.password)
       allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      
      visit discover_path(@user)
    end

    it 'I see the "Find Top Rated Movies" button' do
      click_button 'Find Top Rated Movies'

      expect(current_path).to eq(movies_path(@user))
      expect(page).to have_css("table#top-forty tr", count: 40)
    end
    
    it 'I should also see a form with a button to search for movies by title' do
      fill_in 'movie[search]', with: 'Nacho'
      click_button 'Find Movie'

      expect(current_path).to eq(movies_path(@user))
      expect(page).to have_content('Nacho Libre')
      expect(page).to have_content('Kelly and Nacho')
      expect(page).to have_content('Nacho Mountain')
      expect(page).to_not have_css("table#top-forty tr", count: 41)
    end

    it 'I should see results for movie titles with less than 20 results' do
      fill_in 'movie[search]', with: 'Zipper'
      click_button 'Find Movie'

      expect(current_path).to eq(movies_path(@user))
      expect(page).to have_content("ZIPPER: Coney Island's Last Wild Ride")
    end
  end
end