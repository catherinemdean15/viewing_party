require 'rails_helper'

RSpec.describe 'dashboard index' do
  before :each do
    @user = User.create!(email: 'test5@gmail.com', password: 'test5test5', is_registered?: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    @user.authenticate(@user.password)
    @friend = User.create!(email: 'friend1@email.com', password: 'password', is_registered?: true)
    Friend.create(user_id: @user.id, friend_id: @friend.id)

    @movie_1 = Movie.create!(title: 'Mulan', run_time: '1 hour 12 min', genre: 'Family')
    @movie_2 = Movie.create!(title: 'Oceans 11', run_time: '2 hours 10 min', genre: 'Action')
    @party_1 = @movie_1.parties.create!(start_time: 'beginning time', end_time: 'ending_time')
    @party_2 = @movie_2.parties.create!(start_time: 'beginning time', end_time: 'ending_time')

    PartiesUser.create!(party_id: @party_1.id, user_id: @user.id, host: true)
    PartiesUser.create!(party_id: @party_2.id, user_id: @user.id, host: false)

    visit dashboard_user_path(@user.id)
  end

  it 'has a section that welcomes the user' do
    expect(page).to have_content("Welcome #{@user.email}")
  end

  it 'has a button to search for movies' do
    expect(page).to have_button('Search for movies')

    click_button 'Search for movies'
    expect(current_path).to eq(movies_path)
  end

  it 'has a friends section that lists friends emails' do
    within('#friends') do
      expect(page).to have_content(@friend.email)
    end
  end

  it 'has a viewing parties section that lists viewing parties' do
    within('#viewing_parties') do
      within('#hosting') do
        expect(page).to have_content(@movie_1.title)
        expect(page).to_not have_content(@movie_2.title)
      end
      within('#invited') do
        expect(page).to have_content(@movie_2.title)
        expect(page).to_not have_content(@movie_1.title)
      end
    end
  end
end
