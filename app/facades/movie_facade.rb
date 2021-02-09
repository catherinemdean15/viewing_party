class MovieFacade
  def self.find_top_forty
    top_forty = MovieService.call_moviedb('/3/movie/popular?', { page: 1 })[:results]
    top_forty << MovieService.call_moviedb('/3/movie/popular?', { page: 2 })[:results]
    top_forty.flatten
  end

  def self.find_movies(search)
    params = { query: search, include_adult: true, page: 1 }
     
    matching_movies = MovieService.call_moviedb('/3/search/movie', params)[:results]
    params[:page] += 1
    matching_movies << MovieService.call_moviedb('/3/search/movie', params)[:results]
    matching_movies.flatten
  end

  def self.movie_details(id)
    info    = MovieService.call_moviedb("/3/movie/#{id}")
    cast    = MovieService.call_moviedb("/3/movie/#{id}/credits")
    reviews = MovieService.call_moviedb("/3/movie/#{id}/reviews")
    MovieResult.new(info, cast, reviews)
  end
end
