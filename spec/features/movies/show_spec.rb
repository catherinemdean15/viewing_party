require 'rails_helper'

RSpec.describe 'As an authenticated user', type: :feature do
  describe 'When I visit the discover movies page' do
    before(:each) do
      @user = User.create!(email: 'test5@gmail.com', password: 'test5test5')
      @user.authenticate(@user.password)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @movie_1 = Movie.create!(id: '337401', title: 'Mulan', run_time: '1 hour 12 min')
      @movie_2 = Movie.create!(title: 'Oceans 11', run_time: '2 hours 10 min')

      visit movie_path(@movie_1.id)
    end

    it 'should show movie details when movie exists in database', :vcr do
      expect(page).to have_content('Mulan')
      expect(page).to have_content('When the Emperor of China issues a decree that one man per family must serve in the Imperial Chinese Army to defend the country from Huns, Hua Mulan, the eldest daughter of an honored warrior, steps in to take the place of her ailing father. She is spirited, determined and quick on her feet. Disguised as a man by the name of Hua Jun, she is tested every step of the way and must harness her innermost strength and embrace her true potential.')
      expect(page).to have_content('115 minutes')
      expect(page).to have_content('7.1')
      expect(page).to have_content('Adventure and Fantasy')
      expect(page).to have_content('Liu Yifei as Hua Mulan')
      expect(page).to have_content('Ron Yuan as Sergeant Qiang')
      expect(page).to have_content('msbreviews')
      expect(page).to have_content('A more realistic take on the Chinese tale, one that')
      expect(page).to have_content('Kamurai')
      expect(page).to have_content('After those decisions, they also chose to reintroduce actual magic')
      expect(page).to have_content('Total Reviews: 2')
    end

    it 'should have a button to create a viewing party', :vcr do
      click_button 'Create a Viewing Party'
      expect(current_path).to eq(new_user_party_path(@user))
    end
  end
end
