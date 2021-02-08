class MovieService
  def self.call_moviedb(path)
    response = connection.get(path) 
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