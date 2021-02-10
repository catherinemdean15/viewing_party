require 'rails_helper'

describe MovieService do
  context "instance methods" do
    it "can make API call to database", :vcr do
      query = MovieService.call_moviedb("/3/movie/popular?api_key=#{ENV['movie_api_key']}&page=1")
      movie_data = query[:results].first
      
      expect(query).to be_a Hash
      expect(movie_data).to be_a Hash
      expect(movie_data).to have_key :title
      expect(movie_data[:title]).to be_a(String)
      expect(movie_data).to have_key :vote_average
      expect(movie_data[:vote_average]).to be_a(Numeric)
    end
  end
end