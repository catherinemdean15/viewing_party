class MoviesController < ApplicationController
  def index
    @movies = []
    if params[:search] == 'top_movies'
      @movies = MovieFacade.find_top_forty
    elsif params[:commit] == 'Find Movie'
      @movies = MovieFacade.find_movies(params[:movie][:search])
    elsif params[:genre_name] 
      @movies = MovieFacade.top_ten_movies_by_genre(params[:genre_name])
    end
    flash[:notice] = 'There are no movies with that title. Please try again' if @movies.empty?
  end

  def discover; end

  def show
    @movie = MovieFacade.movie_details(params[:id])
    session[:movie_id] = @movie.id
    session[:movie_title] = @movie.title
    session[:movie_run_time] = @movie.run_time
  end
end
