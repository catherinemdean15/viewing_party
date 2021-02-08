require 'rails_helper'

RSpec.describe 'dashboard index' do
  before :each do
    @user = User.create!(email: 'test5@gmail.com', password: 'test5test5', is_registered?: true)

    @user.authenticate(@user.password)
    @friend_1 = User.create!(email: 'friend1@email.com', password: 'password', is_registered?: true)
    @friend_2 = User.create!(email: 'friend2@email.com', password: 'password', is_registered?: true)
    @friend_3 = User.create!(email: 'friend3@email.com', password: 'password', is_registered?: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    @movie_1 = Movie.create!(title: 'Mulan', run_time: '1 hour 12 min')
    @movie_2 = Movie.create!(title: 'Oceans 11', run_time: '2 hours 10 min')
    @party_1 = @movie_1.parties.create!(start_time: '3:00 PM', date: '20/12/12')
    @party_2 = @movie_2.parties.create!(start_time: '5:00 PM', date: '12/12/12')

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
    expect(current_path).to eq(discover_path)
  end

  it 'has a friends section that lists friends emails and adds friends' do
    within('#friends') do
      expect(page).to have_content('You currently have no friends')

      fill_in 'friend[email]', with: 'friend1@email.com'
      click_button 'Add Friend'
      expect(current_path).to eq(dashboard_user_path(@user.id))
    end

    expect(page).to have_content("You have added #{@friend_1.email} as a friend")

    user = User.find(@user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_user_path(@user.id)

    expect(page).to have_content(@friend_1.email)
    expect(page).to_not have_content(@friend_3.email)
  end

  it 'has a sad path for adding a friend' do
    within('#friends') do
      fill_in 'friend[email]', with: 'silly@email.com'
      click_button 'Add Friend'
      expect(current_path).to eq(dashboard_user_path(@user.id))
    end
    expect(page).to have_content('Please enter valid email address')

    user = User.find(@user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_user_path(@user.id)

    expect(page).to_not have_content('silly@email.com')
  end

  it 'has a viewing parties section that lists viewing parties' do
    within('#viewing_parties') do
      within('#hosting') do
        expect(page).to have_content(@movie_1.title)
        expect(page).to_not have_content(@movie_2.title)
        expect(page).to have_content('December 12, 0020 3:00 PM')
        expect(page).to have_content('Hosting')
      end
      within('#invited') do
        expect(page).to have_content(@movie_2.title)
        expect(page).to_not have_content(@movie_1.title)
        expect(page).to have_content('December 12, 0012 5:00 PM')
        expect(page).to have_content('Invited')
      end
    end
  end
end
