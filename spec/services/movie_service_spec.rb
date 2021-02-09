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

    it "can establish Faraday connection", :vcr do
      connection = MovieService.connection
      
      expect(connection).to be_a Faraday::Connection
    end

    it "can parse the data", :vcr do
      query    = MovieService.connection
      response = query.get("/3/movie/popular?api_key=#{ENV['movie_api_key']}&page=1") 
      parsed   = MovieService.parse_data(response)
      
      expect(parsed).to be_a Hash
      expect(parsed[:results]).to be_an Array
    end
  end
end