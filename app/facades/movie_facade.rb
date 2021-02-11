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

  def self.top_ten_movies_by_genre(genre_name)
    genres = MovieService.call_moviedb('3/genre/movie/list?')[:genres]
    genre_id = genres.find { |name| name[:name] == genre_name }[:id]
    params = { page: 1 }
    movies_by_genre = []
    until movies_by_genre.count >= 10
      movies = MovieService.call_moviedb('/3/discover/movie?', params)[:results]
      if movie[:genre_ids].include?(genre_id) && movie[:vote_average] > 8.0
        movies.each { |movie| movies_by_genre << movie }
      end
      params[:page] += 1
    end
    movies_by_genre
  end
end
