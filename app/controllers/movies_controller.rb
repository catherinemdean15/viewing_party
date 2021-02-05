class MoviesController < ApplicationController
  def index
    @movies = []
    if params[:search] == 'top_movies'
      conn = Faraday.new('https://api.themoviedb.org')
      response1 = conn.get("/3/movie/popular?api_key=#{Figaro.env.movie_api_key}&page=1")
      response2 = conn.get("/3/movie/popular?api_key=#{Figaro.env.movie_api_key}&page=2")
      results1 = JSON.parse(response1.body, symbolize_names: true)
      results2 = JSON.parse(response2.body, symbolize_names: true)
      forty_movies = []
      @movies = forty_movies.push(results1[:results],results2[:results]).flatten
    elsif params[:commit] == 'Find Movie'
      conn = Faraday.new('https://api.themoviedb.org')
      response1 = conn.get("/3/search/movie?api_key=#{Figaro.env.movie_api_key}&query=#{params[:movie][:search]}&page=1&include_adult=true")
      response2 = conn.get("/3/search/movie?api_key=#{Figaro.env.movie_api_key}&query=#{params[:movie][:search]}&page=2&include_adult=true")
      results1 = JSON.parse(response1.body, symbolize_names: true)
      results2 = JSON.parse(response2.body, symbolize_names: true)
      forty_movies = []
      @movies = forty_movies.push(results1[:results],results2[:results]).flatten
    end
  end

  def discover; end
end
