class MovieResult
  attr_reader :genres,
              :summary,
              :average_vote,
              :run_time,
              :cast,
              :reviews,
              :title,
              :id

  def initialize(info, cast, reviews)
    @id           = info[:id]
    @genres       = info[:genres].map { |genre| genre[:name] }
    @summary      = info[:overview]
    @average_vote = info[:vote_average]
    @run_time     = info[:runtime]
    @title        = info[:original_title]
    @cast         = cast[:cast].take(10).map { |member| "#{member[:name]} as #{member[:character]}" }
    @reviews      = reviews[:results].map { |result| { author: result[:author], content: result[:content] } }
  end
end
