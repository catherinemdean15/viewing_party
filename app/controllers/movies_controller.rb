class MoviesController < ApplicationController
  def index
    @movies = []
    if params[:search] == 'top_movies'
      conn = Faraday.new('https://api.themoviedb.org')
      response1 = conn.get("/3/movie/popular?api_key=#{ENV['movie_api_key']}&page=1")
      response2 = conn.get("/3/movie/popular?api_key=#{ENV['movie_api_key']}&page=2")
      results1 = JSON.parse(response1.body, symbolize_names: true)
      results2 = JSON.parse(response2.body, symbolize_names: true)
      forty_movies = []
      @movies = forty_movies.push(results1[:results], results2[:results]).flatten
    elsif params[:commit] == 'Find Movie'
      conn = Faraday.new('https://api.themoviedb.org')
      response1 = conn.get("/3/search/movie?api_key=#{ENV['movie_api_key']}&query=#{params[:movie][:search]}&page=1&include_adult=true")
      response2 = conn.get("/3/search/movie?api_key=#{ENV['movie_api_key']}&query=#{params[:movie][:search]}&page=2&include_adult=true")
      results1 = JSON.parse(response1.body, symbolize_names: true)
      results2 = JSON.parse(response2.body, symbolize_names: true)
      forty_movies = []
      @movies = forty_movies.push(results1[:results], results2[:results]).flatten
    end
    flash[:notice] = 'There are no movies with that title. Please try again' if @movies.empty?
  end

  def discover; end

  def show
    conn = Faraday.new('https://api.themoviedb.org')
    movie_info = conn.get("/3/movie/#{params[:id]}?api_key=#{ENV['movie_api_key']}")
    movie_results = JSON.parse(movie_info.body, symbolize_names: true)
    @movie = { title: movie_results[:original_title],
               summary: movie_results[:overview],
               average_vote: movie_results[:vote_average],
               run_time: movie_results[:runtime],

               genres: movie_results[:genres].map { |genre| genre[:name] } }
    require 'pry'; binding.pry
  end
end
