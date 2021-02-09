class MoviesController < ApplicationController
  def index
    @movies = []
    if params[:search] == 'top_movies'
      @movies = MovieFacade.find_top_forty
    elsif params[:commit] == 'Find Movie'
      @movies = MovieFacade.find_movies(params[:movie][:search])
    end
    flash[:notice] = 'There are no movies with that title. Please try again' if @movies.empty?
  end

  def discover; end

  def show
    @movie = MovieFacade.movie_details(params[:id])
  end
end
