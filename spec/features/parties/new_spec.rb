require 'rails_helper'

RSpec.describe 'As an authenticated user', type: :feature do
  describe 'When I visit the create a new party page' do
    before(:each) do
      @user = User.create!(email: 'test5@gmail.com', password: 'test5test5', is_registered?: true)
      @user.authenticate(@user.password)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @movie_1 = Movie.create!(id: '337401')

      @friend_1 = User.create!(email: 'friend1@email.com', password: 'password', is_registered?: true)
      @friend_2 = User.create!(email: 'friend2@email.com', password: 'password', is_registered?: true)
      @friend_3 = User.create!(email: 'friend3@email.com', password: 'password', is_registered?: true)
      Friend.create!(friend1_id: @user.id, friend2_id: @friend_1.id)
      Friend.create!(friend1_id: @user.id, friend2_id: @friend_2.id)
      Friend.create!(friend1_id: @user.id, friend2_id: @friend_3.id)

      visit movie_path(@movie_1.id)
    end

    it 'has a form to create a new party', :vcr do
      click_button 'Create a Viewing Party'

      expect(page).to have_content('Mulan')

      fill_in 'party[date]', with: '2021/03/12'
      fill_in 'party[start_time]', with: '3:00 PM'
      check "User[#{@friend_1.id}]"
      click_button 'Create new Party'

      expect(current_path).to eq(dashboard_user_path(@user))
      expect(page).to have_content('March 12, 2021')
      expect(page).to have_content('3:00 PM')
      expect(page).to have_content('Hosting')

      visit(dashboard_user_path(@friend_1))
      expect(page).to have_content('March 12, 2021')
      expect(page).to have_content('3:00 PM')
      expect(page).to have_content('Invited')
    end

    it 'has a sad path when creating a new party', :vcr do
      click_button 'Create a Viewing Party'

      fill_in 'party[date]', with: '2021/03/12'

      click_button 'Create new Party'

      expect(page).to have_content('Please complete all forms')
    end
  end
end
