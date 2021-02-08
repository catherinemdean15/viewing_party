class MovieFacade
  def self.get_top_forty
    results1 = MovieService.call_moviedb("/3/movie/popular?api_key=#{ENV['movie_api_key']}&page=1")
    results2 = MovieService.call_moviedb("/3/movie/popular?api_key=#{ENV['movie_api_key']}&page=2")
    top_forty = [results1[:results], results2[:results]]
    top_forty.flatten
  end

  def self.find_movies(search)
    results1 = MovieService.call_moviedb("/3/search/movie?api_key=#{ENV['movie_api_key']}&query=#{search}&page=1&include_adult=true")
    results2 = MovieService.call_moviedb("/3/search/movie?api_key=#{ENV['movie_api_key']}&query=#{search}&page=2&include_adult=true")
    matching_movies = [results1[:results], results2[:results]]
    matching_movies.flatten
  end

  def self.movie_details(id)
    info = MovieService.call_moviedb("/3/movie/#{id}?api_key=#{ENV['movie_api_key']}")
    cast = MovieService.call_moviedb("/3/movie/#{id}/credits?api_key=#{ENV['movie_api_key']}")
    reviews = MovieService.call_moviedb("/3/movie/#{id}/reviews?api_key=#{ENV['movie_api_key']}")
    movie =  { 
              title: info[:original_title],
              summary: info[:overview],
              average_vote: info[:vote_average],
              run_time: info[:runtime],
              genres: info[:genres].map {|genre| genre[:name]},
              cast: cast[:cast].take(10).map {|member| "#{member[:name]} as #{member[:character]}"},
              reviews: reviews[:results].map {|result| {author: result[:author], content: result[:content]}} 
            }
  end
end