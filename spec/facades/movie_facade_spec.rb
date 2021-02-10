require 'rails_helper'

describe MovieFacade do
  context "instance methods" do
    it "returns movies matching search", :vcr do
      search = MovieFacade.find_movies('Mulan')
      expect(search).to be_an Array
      movie_data = search.first
      expect(movie_data).to be_a Hash

      expect(movie_data).to have_key :title
      expect(movie_data[:title]).to be_a(String)

      expect(movie_data).to have_key :vote_average
      expect(movie_data[:vote_average]).to be_a(Numeric)
    end

    it "returns top movies", :vcr do
      search = MovieFacade.find_top_forty
      expect(search).to be_an Array
      movie_data = search.first
      expect(movie_data).to be_a Hash

      expect(movie_data).to have_key :title
      expect(movie_data[:title]).to be_a(String)

      expect(movie_data).to have_key :vote_average
      expect(movie_data[:vote_average]).to be_a(Numeric)
    end

    it "lists movie details", :vcr do
      search = MovieFacade.movie_details(33740)
      
      expect(search).to be_a MovieResult
      expect(search.title).to be_a(String)
      expect(search.average_vote).to be_a(Numeric)
      expect(search.summary).to be_a(String)
      expect(search.run_time).to be_an(Integer)
      expect(search.genres).to be_an(Array)
      expect(search.cast).to be_an(Array)
      expect(search.reviews).to be_an(Array)
    end
  end
end