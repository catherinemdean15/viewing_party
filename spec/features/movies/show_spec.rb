require 'rails_helper'

RSpec.describe 'As an authenticated user', type: :feature do
  describe 'When I visit the discover movies page' do
    before(:each) do
      @user = User.create!(email: 'test5@gmail.com', password: 'test5test5', is_registered?: true)
      @user.authenticate(@user.password)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @movie_1 = Movie.create!(title: 'Mulan', run_time: '1 hour 12 min')
      @movie_2 = Movie.create!(title: 'Oceans 11', run_time: '2 hours 10 min')

      visit movie_path(@user, @movie_1)
    end

    it 'should show movie details when movie exists in database' do
      JSON_response = File.read('/spec/fixtures/movie_info_data.json')
      stub_request(:get, "https://api.themoviedb.org/3/movie/#{@movie_1.id}?api_key=#{ENV['movie_api_key']}")
        .to_return(status: 200, body: JSON_response)

      # search NachoLibre
      # make API call and get the info
      # store temporarily somehow (hash/json)
      # retrieve info
      expect(page).to have_content('Mulan')
    end

    xit 'should have a button to create a viewing party' do
      expect(page).to have_button('Create a Viewing Party')
    end
  end
end
