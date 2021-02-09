class MovieService
  def self.call_moviedb(path, params = {})
    response = connection.get(path) do |req|
      req.params = params
      req.params[:api_key] = ENV['movie_api_key']
    end
    parse_data(response)
  end

  private

  def self.connection
    Faraday.new('https://api.themoviedb.org') 
  end

  def self.parse_data(data)
    JSON.parse(data.body, symbolize_names: true)
  end
end